use alloc::string::{String, ToString};
use alloc::sync::{Arc, Weak};
use alloc::vec;
use alloc::vec::Vec;

use spin::Mutex;

use crate::config::{AT_EXECFN, AT_NULL, AT_RANDOM, FD_MAX, MAP_FIXED, MEMORY_MAP_BASE, PAGE_SIZE};
use crate::fs::{
    File, FileDescriptor, FileType, open_file, OpenFlags, OSInode, Stdin, Stdout, WorkPath,
};
use crate::mm::{
    AuxHeader, KERNEL_SPACE, MapPermission, MemoryMapArea, MemorySet,
    translated_byte_buffer, translated_ref, translated_refmut, UserBuffer, VirtAddr, VirtPageNum, VPNRange,
};
use crate::task::SignalStruct;
use crate::trap::{trap_handler, TrapContext};

use super::{add_task, current_user_token, ITimerVal, Signum};
use super::{pid_alloc, PidHandle};
use super::id::RecycleAllocator;
use super::manager::{insert_into_pid2process, insert_into_tid2task};
use super::TaskControlBlock;

const AT_FD_CWD: isize = -100;

pub struct ProcessControlBlock {
    // immutable
    pub pid: PidHandle,
    // mutable
    inner: Mutex<ProcessControlBlockInner>,
}

pub struct PCBAttribute {
    pub set_child_tid: usize,
    pub clear_child_tid: usize,
}

pub struct ProcessControlBlockInner {
    pub is_zombie: bool,
    pub memory_set: MemorySet,
    pub parent: Option<Weak<ProcessControlBlock>>,
    pub children: Vec<Arc<ProcessControlBlock>>,
    pub exit_code: i32,
    pub fd_table: Vec<Option<FileDescriptor>>,
    pub fd_max: usize,
    /// 信号处理方式列表
    pub signal_actions: SignalStruct,
    pub tasks: Vec<Option<Arc<TaskControlBlock>>>,
    pub task_res_allocator: RecycleAllocator,
    //工作目录
    pub work_path: WorkPath,
    //tid attribute
    // pub tid_attr: PCBAttribute,
    // user_heap
    pub heap_base: VirtAddr,
    pub heap_end: VirtAddr,
    pub mmap_area_base: VirtAddr,
    pub mmap_area_end: VirtAddr,
    // 定时器信息
    pub itimer: ITimerVal,
}

impl ProcessControlBlockInner {
    #[allow(unused)]
    pub fn get_user_token(&self) -> usize {
        self.memory_set.token()
    }
    
    pub fn alloc_fd(&mut self) -> usize {
        if let Some(fd) = (0..self.fd_table.len()).find(|fd| self.fd_table[*fd].is_none()) {
            fd
        } else {
            self.fd_table.push(None);
            self.fd_table.len() - 1
        }
    }
    
    // alloc a specific new_fd
    pub fn alloc_specific_fd(&mut self, new_fd: usize) -> usize {
        for _ in self.fd_table.len()..=new_fd {
            self.fd_table.push(None);
        }
        new_fd
    }
    
    pub fn alloc_id(&mut self) -> usize {
        self.task_res_allocator.alloc()
    }
    
    pub fn dealloc_id(&mut self, id: usize) {
        self.task_res_allocator.dealloc(id)
    }
    
    pub fn thread_count(&self) -> usize {
        self.tasks.len()
    }
    
    pub fn get_task(&self, tid: usize) -> Arc<TaskControlBlock> {
        self.tasks[tid].as_ref().unwrap().clone()
    }
}

impl ProcessControlBlock {
    pub fn is_locked(&self) -> bool {
        self.inner.is_locked()
    }
    
    pub fn inner_exclusive_access(&self) -> spin::MutexGuard<'_, ProcessControlBlockInner> {
        self.inner.lock()
    }
    
    //只有init proc调用,其他的线程从fork产生
    pub fn new(elf_data: &[u8]) -> Arc<Self> {
        // memory_set with elf program headers/trampoline/trap context/user stack
        let (memory_set, uheap_base, ustack_base, entry_point, _) = MemorySet::from_elf(elf_data);
        // allocate a pid
        let pid_handle = pid_alloc();
        let process = Arc::new(Self {
            pid: pid_handle,
            inner: unsafe {
                Mutex::new(ProcessControlBlockInner {
                    is_zombie: false,
                    memory_set,
                    parent: None,
                    children: Vec::new(),
                    exit_code: 0,
                    fd_table: vec![
                        // 0 -> stdin
                        Some(FileDescriptor::Abstract(Arc::new(Stdin))),
                        // 1 -> stdout
                        Some(FileDescriptor::Abstract(Arc::new(Stdout))),
                        // 2 -> stderr
                        Some(FileDescriptor::Abstract(Arc::new(Stdout))),
                    ],
                    fd_max: FD_MAX,
                    // signals: Signum::empty(),
                    // signal_handling: 0,
                    // signal_masks: Signum::empty(),
                    signal_actions: SignalStruct::default(),
                    // killed: false,
                    // frozen: false,
                    // trap_ctx_backup: None,
                    tasks: Vec::new(),
                    task_res_allocator: RecycleAllocator::new(),
                    work_path: WorkPath::new(),
                    // tid_attr: PCBAttribute {
                    //     set_child_tid: 0,
                    //     clear_child_tid: 0,
                    // },
                    heap_base: uheap_base.into(),
                    heap_end: uheap_base.into(),
                    mmap_area_base: MEMORY_MAP_BASE.into(),
                    mmap_area_end: MEMORY_MAP_BASE.into(),
                    itimer: ITimerVal::new(),
                })
            },
        });
        // create a main thread, we should allocate ustack and trap_cx here
        let task = Arc::new(TaskControlBlock::new(
            Arc::clone(&process),
            ustack_base,
            true,
        ));
        insert_into_tid2task(task.gettid(), Arc::clone(&task));
        // prepare trap_cx of main thread
        let task_inner = task.inner_exclusive_access();
        let trap_cx = task_inner.get_trap_cx();
        let ustack_top = task_inner.res.as_ref().unwrap().ustack_top();
        let kstack_top = task.kstack.get_top();
        drop(task_inner);
        *trap_cx = TrapContext::app_init_context(
            entry_point,
            ustack_top,
            KERNEL_SPACE.lock().token(),
            kstack_top,
            trap_handler as usize,
        );
        // add main thread to the process
        let mut process_inner = process.inner_exclusive_access();
        process_inner.tasks.push(Some(Arc::clone(&task)));
        drop(process_inner);
        insert_into_pid2process(process.getpid(), Arc::clone(&process));
        // add main thread to scheduler
        add_task(task);
        process
    }
    
    /// Only support processes with a single thread.
    pub fn exec(self: &Arc<Self>, elf_data: &[u8], args: Vec<String>) {
        assert_eq!(self.inner_exclusive_access().thread_count(), 1);
        // memory_set with elf program headers/trampoline/trap context/user stack/auxv
        let (memory_set, uheap_base, ustack_base, entry_point, mut auxv) =
            MemorySet::from_elf(elf_data);
        let new_token = memory_set.token();
        //println!("heap base {:#x}", uheap_base);
        //println!("stack base {:#x}", ustack_base);
        //println!("entry pointer {:#x}", entry_point);
        //println!("args: {:#?}", args);
        /////////// envp [] /////////////////
        let envs = vec![
            String::from("SHELL=/user_shell"),
            String::from("PWD=/"),
            String::from("USER=root"),
            String::from("MOTD_SHOWN=pam"),
            String::from("LANG=C.UTF-8"),
            String::from("INVOCATION_ID=e9500a871cf044d9886a157f53826684"),
            String::from("TERM=vt220"),
            String::from("SHLVL=2"),
            String::from("JOURNAL_STREAM=8:9265"),
            String::from("OLDPWD=/root"),
            String::from("_=busybox"),
            String::from("LOGNAME=root"),
            String::from("HOME=/"),
            String::from("LD_LIBRARY_PATH=/"),
            String::from("PATH=/"),
        ];
        
        // substitute memory_set
        let mut inner = self.inner_exclusive_access();
        inner.memory_set = memory_set;
        // 重新设置堆大小
        inner.heap_base = uheap_base.into();
        inner.heap_end = uheap_base.into();
        // 重新设置mmap_area
        inner.mmap_area_base = MEMORY_MAP_BASE.into();
        inner.mmap_area_end = MEMORY_MAP_BASE.into();
        drop(inner);
        // then we alloc user resource for main thread again
        // since memory_set has been changed
        let task = self.inner_exclusive_access().get_task(0);
        let mut task_inner = task.inner_exclusive_access();
        task_inner.res.as_mut().unwrap().ustack_base = ustack_base;
        task_inner.res.as_mut().unwrap().alloc_user_res();
        task_inner.trap_cx_ppn = task_inner.res.as_mut().unwrap().trap_cx_ppn();
        // push arguments on user stack
        
        let mut user_sp = task_inner.res.as_mut().unwrap().ustack_top();
        
        //stack top
        //argc
        //*argv[] with null as end
        //*envp[] with null as end
        //aux[] with null as end
        //padding (16 bytes align)
        //rand bytes
        //string: platform
        //argv[]
        //envp[]
        //stack bottom
        
        let push_stack = |parms: Vec<String>, user_sp: &mut usize| {
            //record parm ptr
            let mut ptr_vec: Vec<usize> = (0..=parms.len()).collect();
            
            //end with null
            ptr_vec[parms.len()] = 0;
            
            for index in 0..parms.len() {
                *user_sp -= parms[index].len() + 1;
                ptr_vec[index] = *user_sp;
                let mut p = *user_sp;
                
                //write chars to [user_sp,user_sp + len]
                for c in parms[index].as_bytes() {
                    *translated_refmut(new_token, p as *mut u8) = *c;
                    p += 1;
                }
                *translated_refmut(new_token, p as *mut u8) = 0;
            }
            ptr_vec
        };
        
        //////////////////////// envp[] ////////////////////////////////
        let envp = push_stack(envs, &mut user_sp);
        // make sure aligned to 8b for k210
        user_sp -= user_sp % core::mem::size_of::<usize>();
        
        ///////////////////// argv[] /////////////////////////////////
        let argc = args.len();
        let argv = push_stack(args, &mut user_sp);
        // make the user_sp aligned to 8B for k210 platform
        user_sp -= user_sp % core::mem::size_of::<usize>();
        
        ///////////////////// platform ///////////////////////////////
        let platform = "RISC-V64";
        user_sp -= platform.len() + 1;
        user_sp -= user_sp % core::mem::size_of::<usize>();
        let mut p = user_sp;
        for &c in platform.as_bytes() {
            *translated_refmut(new_token, p as *mut u8) = c;
            p += 1;
        }
        *translated_refmut(new_token, p as *mut u8) = 0;
        
        ///////////////////// rand bytes ////////////////////////////
        user_sp -= 16;
        auxv.push(AuxHeader::new(AT_RANDOM, user_sp));
        *translated_refmut(new_token, user_sp as *mut usize) = 0x01020304050607;
        *translated_refmut(
            new_token,
            (user_sp + core::mem::size_of::<usize>()) as *mut usize,
        ) = 0x08090a0b0c0d0e0f;
        
        ///////////////////// padding ////////////////////////////////
        user_sp -= user_sp % 16;
        
        ///////////////////// auxv[] //////////////////////////////////
        auxv.push(AuxHeader::new(AT_EXECFN, argv[0]));
        auxv.push(AuxHeader::new(AT_NULL, 0));
        user_sp -= auxv.len() * core::mem::size_of::<AuxHeader>();
        let aux_base = user_sp;
        let mut addr = aux_base;
        for aux_header in auxv {
            *translated_refmut(new_token, addr as *mut usize) = aux_header._type;
            *translated_refmut(
                new_token,
                (addr + core::mem::size_of::<usize>()) as *mut usize,
            ) = aux_header.value;
            addr += core::mem::size_of::<AuxHeader>();
        }
        
        ///////////////////// *envp[] /////////////////////////////////
        user_sp -= envp.len() * core::mem::size_of::<usize>();
        let envp_base = user_sp;
        let mut ustack_ptr = envp_base;
        for env_ptr in envp {
            *translated_refmut(new_token, ustack_ptr as *mut usize) = env_ptr;
            ustack_ptr += core::mem::size_of::<usize>();
        }
        
        ///////////////////// *argv[] ////////////////////////////////
        user_sp -= argv.len() * core::mem::size_of::<usize>();
        let argv_base = user_sp;
        let mut ustack_ptr = argv_base;
        for argv_ptr in argv {
            *translated_refmut(new_token, ustack_ptr as *mut usize) = argv_ptr;
            ustack_ptr += core::mem::size_of::<usize>();
        }
        
        ///////////////////// argc ///////////////////////////////////
        user_sp -= core::mem::size_of::<usize>();
        *translated_refmut(new_token, user_sp as *mut usize) = argc;
        
        // initialize trap_cx
        let mut trap_cx = TrapContext::app_init_context(
            entry_point,
            user_sp,
            KERNEL_SPACE.lock().token(),
            task.kstack.get_top(),
            trap_handler as usize,
        );
        
        trap_cx.x[10] = argc; //argc
        trap_cx.x[11] = argv_base; //argv
        trap_cx.x[12] = envp_base; //envp
        trap_cx.x[13] = aux_base; //auxv
        *task_inner.get_trap_cx() = trap_cx;
    }
    
    /// Only support processes with a single thread.
    pub fn fork(self: &Arc<Self>) -> Arc<Self> {
        let mut parent = self.inner_exclusive_access();
        assert_eq!(parent.thread_count(), 1);
        // clone parent's memory_set completely including trampoline/ustacks/trap_cxs
        let memory_set = MemorySet::from_existed_user(&parent.memory_set);
        // alloc a pid
        let pid = pid_alloc();
        // copy fd table
        let mut new_fd_table: Vec<Option<FileDescriptor>> = Vec::new();
        for fd in parent.fd_table.iter() {
            if let Some(file) = fd {
                new_fd_table.push(Some(file.clone()));
            } else {
                new_fd_table.push(None);
            }
        }
        // copy work path
        let path = parent.work_path.clone();
        // create child process pcb
        let child = Arc::new(Self {
            pid,
            inner: unsafe {
                Mutex::new(ProcessControlBlockInner {
                    is_zombie: false,
                    memory_set,
                    parent: Some(Arc::downgrade(self)),
                    children: Vec::new(),
                    exit_code: 0,
                    fd_table: new_fd_table,
                    fd_max: FD_MAX,
                    // signals: Signum::empty(),
                    // signal_handling: 0,
                    // signal_masks: Signum::empty(),
                    signal_actions: SignalStruct::default(),
                    // killed: false,
                    // frozen: false,
                    // trap_ctx_backup: None,
                    tasks: Vec::new(),
                    task_res_allocator: RecycleAllocator::new(),
                    work_path: path,
                    // tid_attr: PCBAttribute {
                    //     set_child_tid: 0,
                    //     clear_child_tid: 0,
                    // },
                    heap_base: parent.heap_base,
                    heap_end: parent.heap_end,
                    mmap_area_base: parent.mmap_area_base,
                    mmap_area_end: parent.mmap_area_end,
                    itimer: ITimerVal::new(),
                })
            },
        });
        // add child
        parent.children.push(Arc::clone(&child));
        // create main thread of child process
        let task = Arc::new(TaskControlBlock::new(
            Arc::clone(&child),
            parent
                .get_task(0)
                .inner_exclusive_access()
                .res
                .as_ref()
                .unwrap()
                .ustack_base(),
            // here we do not allocate trap_cx or ustack again
            // but mention that we allocate a new kstack here
            false,
        ));
        insert_into_tid2task(task.gettid(), Arc::clone(&task));
        // attach task to child process
        let mut child_inner = child.inner_exclusive_access();
        child_inner.tasks.push(Some(Arc::clone(&task)));
        drop(child_inner);
        // modify kstack_top in trap_cx of this thread
        let task_inner = task.inner_exclusive_access();
        let trap_cx = task_inner.get_trap_cx();
        trap_cx.kernel_sp = task.kstack.get_top();
        drop(task_inner);
        insert_into_pid2process(child.getpid(), Arc::clone(&child));
        // add this thread to scheduler
        add_task(task);
        child
    }
    
    pub fn clone_thread(
        self: &Arc<Self>,
        parent_task: Arc<TaskControlBlock>,
    ) -> Arc<TaskControlBlock> {
        let task = Arc::new(TaskControlBlock::new(
            Arc::clone(self),
            parent_task
                .inner_exclusive_access()
                .res
                .as_ref()
                .unwrap()
                .ustack_base(),
            true,
        ));
        
        // attach task to child process
        let task_id = task.get_task_id();
        let tasks = &mut self.inner_exclusive_access().tasks;
        while tasks.len() < task_id + 1 {
            tasks.push(None);
        }
        tasks[task_id] = Some(Arc::clone(&task));
        
        // modify kstack_top in trap_cx of this thread
        let task_inner = task.inner_exclusive_access();
        let trap_cx = task_inner.get_trap_cx();
        *trap_cx = *parent_task.inner_exclusive_access().get_trap_cx();
        trap_cx.kernel_sp = task.kstack.get_top();
        
        drop(task_inner);
        insert_into_tid2task(task.gettid(), Arc::clone(&task));
        add_task(Arc::clone(&task));
        
        task
    }
    
    pub fn getpid(&self) -> usize {
        self.pid.0
    }
    
    pub fn mmap(
        &self,
        start: usize,
        len: usize,
        prot: usize,
        flags: usize,
        fd: usize,
        offset: usize,
    ) {
        let start_va = start.into();
        let end_va = (start + len).into();
        // 测例prot定义与MapPermission正好差一位
        let map_perm = MapPermission::from_bits((prot << 1) as u8).unwrap() | MapPermission::U;
        // overlap
        if flags & MAP_FIXED != 0 {
            let start_vpn = VirtPageNum::from(start_va);
            let end_vpn = VirtPageNum::from(end_va);
            //TODO 可能有部分区间重叠情况考虑不到位
            // println!("fixed handle start ...");
            // println!("[new mmap in] start_vpn:{:#?}  end_vpn:{:#?}",start_vpn,end_vpn);
            // let mut collision = false;
            let mut old_perm = MapPermission::U;
            let mut old_start = VirtAddr::from(0).floor();
            let mut old_end = VirtAddr::from(0).floor();
            let mut old_flags = 0usize;
            let mut old_fd = 0usize;
            let mut old_offset = 0usize;
            loop {
                let mut loop_flag = true;
                // let mut index = 0;
                // for (i,mmap_area) in inner.memory_set.mmap_areas.iter().enumerate(){
                for mmap_area in self.inner_exclusive_access().memory_set.mmap_areas.iter() {
                    // 在此处提取old_area相关信息
                    // 1                  1
                    // fix area        |----- - -
                    // old area           |----|
                    // 3                    3
                    // fix area          |-- - - -
                    // old area        |-----|
                    if (start_vpn < mmap_area.vpn_range.get_start()
                        && end_vpn > mmap_area.vpn_range.get_start())
                        || (start_vpn >= mmap_area.vpn_range.get_start()
                        && start_vpn < mmap_area.vpn_range.get_end())
                    {
                        old_perm = mmap_area.map_perm;
                        old_start = mmap_area.vpn_range.get_start();
                        old_end = mmap_area.vpn_range.get_end();
                        old_flags = mmap_area.flags;
                        old_offset = mmap_area.offset;
                        old_fd = mmap_area.fd;
                        loop_flag = false;
                    }
                }
                if loop_flag {
                    break;
                }
                // println!("fixed handle real start ...");
                self.inner_exclusive_access()
                    .memory_set
                    .remove_mmap_area(old_start);
                // fix area        |-----|
                // old area           |----|
                if start_vpn <= old_start && end_vpn > old_start && end_vpn < old_end {
                    // println!("fixed situation 1");
                    let u_old_start: usize = old_start.into();
                    // 向上取整页
                    old_offset = old_offset
                        + ((len + start - u_old_start + PAGE_SIZE - 1) / PAGE_SIZE) * PAGE_SIZE;
                    old_start = VirtAddr::from(start + len).ceil();
                    // println!("[part-1]fixed situation 1  start_vpn:{:#?}  end_vpn:{:#?}",old_start,old_end);
                    // println!("[part-2]fixed situation 1  start_vpn:{:#?}  end_vpn:{:#?}",start_vpn,end_vpn);
                    self.inner_exclusive_access()
                        .memory_set
                        .insert_mmap_area(MemoryMapArea::new(
                            old_start.into(),
                            old_end.into(),
                            old_perm,
                            old_flags,
                            old_fd,
                            old_offset,
                        ));
                    self.inner_exclusive_access()
                        .memory_set
                        .alloc_mmap_area(old_start.into());
                    self.map_file_for_mmap(VirtAddr::from(old_start).0);
                } else
                // fix area        |----------|
                // old area           |----|
                // 刚好完全覆盖的情况也在此处
                if start_vpn <= old_start && end_vpn >= old_end {
                    // println!("fixed situation 2");
                    // println!("[part-2]fixed situation 2  start_vpn:{:#?}  end_vpn:{:#?}",start_vpn,end_vpn);
                } else
                // fix area          |--|
                // old area        |-----|
                if start_vpn >= old_start && end_vpn <= old_end {
                    // println!("fixed situation 3");
                    if end_vpn != old_end {
                        // 向上取整页
                        let u_old_start: usize = old_start.into();
                        let part3_offset = old_offset
                            + ((len + start - u_old_start + PAGE_SIZE - 1) / PAGE_SIZE) * PAGE_SIZE;
                        let part3_start = VirtAddr::from(start + len).ceil();
                        let part3_end = old_end;
                        let part3_perm = old_perm;
                        let part3_flags = old_flags;
                        let part3_fd = old_fd;
                        // println!("[part-3]fixed situation 3  start_vpn:{:#?}  end_vpn:{:#?}",part3_start,part3_end);
                        self.inner_exclusive_access().memory_set.insert_mmap_area(
                            MemoryMapArea::new(
                                part3_start.into(),
                                part3_end.into(),
                                part3_perm,
                                part3_flags,
                                part3_fd,
                                part3_offset,
                            ),
                        );
                        self.inner_exclusive_access()
                            .memory_set
                            .alloc_mmap_area(part3_start.into());
                        self.map_file_for_mmap(VirtAddr::from(part3_start).0);
                    }
            
                    // println!("[part-2]fixed situation 3  start_vpn:{:#?}  end_vpn:{:#?}",start_vpn,end_vpn);
                    if start_vpn != old_start {
                        // 原区域作为第一段
                        old_end = VirtAddr::from(start + PAGE_SIZE - 1).floor();
                        // println!("[part-1]fixed situation 3  start_vpn:{:#?}  end_vpn:{:#?}",old_start,old_end);
                        self.inner_exclusive_access().memory_set.insert_mmap_area(
                            MemoryMapArea::new(
                                old_start.into(),
                                old_end.into(),
                                old_perm,
                                old_flags,
                                old_fd,
                                old_offset,
                            ),
                        );
                        self.inner_exclusive_access()
                            .memory_set
                            .alloc_mmap_area(old_start.into());
                        self.map_file_for_mmap(VirtAddr::from(old_start).0);
                    }
                } else
                // fix area          |-------|
                // old area        |-----|
                if start_vpn > old_start && end_vpn > old_end {
                    // println!("fixed situation 4");
                    // 原区域作为第一段
                    old_end = VirtAddr::from(start + PAGE_SIZE - 1).floor();
                    // println!("[part-1]fixed situation 4  start_vpn:{:#?}  end_vpn:{:#?}",old_start,old_end);
                    // println!("[part-2]fixed situation 4  start_vpn:{:#?}  end_vpn:{:#?}",start_vpn,end_vpn);
                    self.inner_exclusive_access()
                        .memory_set
                        .insert_mmap_area(MemoryMapArea::new(
                            old_start.into(),
                            old_end.into(),
                            old_perm,
                            old_flags,
                            old_fd,
                            old_offset,
                        ));
                    self.inner_exclusive_access()
                        .memory_set
                        .alloc_mmap_area(old_start.into());
                    self.map_file_for_mmap(VirtAddr::from(old_start).0);
                }
            }
        }
        let mut inner = self.inner_exclusive_access();
        inner.memory_set.insert_mmap_area(MemoryMapArea::new(
            start_va, end_va, map_perm, fd, offset, flags,
        ));
        inner.mmap_area_end = inner.mmap_area_end.max(end_va);
        inner.memory_set.alloc_mmap_area(start_va);
        drop(inner);
        self.map_file_for_mmap(start);
    }
    
    pub fn munmap(&self, start: usize, len: usize) -> bool {
        let start_vpn = VirtPageNum::from(VirtAddr::from(start));
        self.inner_exclusive_access()
            .memory_set
            .remove_mmap_area(start_vpn)
    }
    
    /// 映射文件
    pub fn map_file_for_mmap(&self, addr: usize) {
        // TODO: start, end, offset, vpn
        let mut inner = self.inner_exclusive_access();
        let token = inner.memory_set.token();
        let fd_table = inner.fd_table.clone();
        let vpn = VirtPageNum::from(VirtAddr::from(addr));
        
        let mut flag = false;
        let mut vpn_range = VPNRange::new(0.into(), 0.into());
        let mut fd = 0;
        let mut offset = 0;
        
        for area in inner.memory_set.mmap_areas.iter() {
            if area.vpn_range.contain(vpn) {
                flag = true;
                vpn_range = area.vpn_range.clone();
                fd = area.fd;
                offset = area.fd;
            }
        }
        
        drop(inner);
        if flag {
            for vpn in vpn_range.into_iter() {
                if let Some(file_descriptor) = &fd_table[fd] {
                    match file_descriptor {
                        FileDescriptor::Regular(inode) => {
                            if inode.readable() {
                                let mmap_base = VirtAddr::from(vpn).0;
                                let page_offset = addr - mmap_base + offset;
                                let buf =
                                    translated_byte_buffer(token, addr as *const u8, PAGE_SIZE);
                                inode.set_offset(page_offset);
                                inode.read(UserBuffer::new(buf));
                            }
                        }
                        FileDescriptor::Abstract(_) => {}
                    }
                }
            }
        }
        return;
    }
}
//
//impl UPIntrRefMut<'_, ProcessControlBlockInner> {
//    /// 打开dirfd文件夹下，路径为path的文件
//    pub fn open_file(self, dirfd: isize, path: String, flags: OpenFlags) -> Option<Arc<OSInode>> {
//        if WorkPath::is_abs_path(&path) {
//            drop(self);
//            open_file("/", &path, flags, FileType::Regular)
//        } else if dirfd == AT_FD_CWD {
//            let work_path = self.work_path.to_string();
//            drop(self);
//            open_file(&work_path, &path, flags, FileType::Dir)
//        } else {
//            if dirfd as usize >= self.fd_table.len() {
//                return None;
//            }
//
//            if let Some(FileDescriptor::Regular(os_inode)) = self.fd_table[dirfd as usize].clone() {
//                if !os_inode.is_dir() {
//                    return None;
//                }
//                drop(self);
//                os_inode.create(&path, FileType::Regular)
//            } else {
//                None
//            }
//        }
//    }
//}
