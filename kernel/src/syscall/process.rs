use alloc::format;
use alloc::string::{String, ToString};
use alloc::sync::Arc;
use alloc::vec::Vec;
use core::mem::size_of;

use crate::config::{CLOCK_FREQ, MAP_ANONYMOUS, PAGE_SIZE, MAP_FIXED, FD_MAX, RLIMIT_FSIZE, RLIMIT_NOFILE};
use crate::console::{ERROR, INFO, WARNING};
use crate::fs_fat::{File, FileDescriptor, FileType, open_file, OpenFlags};
use crate::mm::{
    align_up, translated_byte_buffer, translated_ref, translated_refmut, translated_str, UserBuffer, VirtPageNum, PTEFlags, VirtAddr,
};
use crate::syscall::thread::sys_gettid;
use crate::task::{
    add_task, current_process, current_task, current_user_token, exit_current_and_run_next,
    pid2process, suspend_current_and_run_next, CloneFlag, ITimerVal, SigAction, SigInfo, Signum,
    TimeSpec, ITIMER_MANAGER, MAX_SIG, SIG_BLOCK, SIG_SETMASK, SIG_UNBLOCK, tid2task, UContext, ClearChildTid,
};
use crate::timer::{get_time, get_time_ms, get_time_ns, get_time_us, NSEC_PER_SEC, USEC_PER_SEC};
use crate::trap::lazy_check;

pub fn sys_exit(exit_code: i32) -> ! {
    exit_current_and_run_next(exit_code);
    panic!("Unreachable in sys_exit!");
}

pub fn sys_yield() -> isize {
    suspend_current_and_run_next();
    0
}

pub fn sys_get_time_of_day(ts: *mut u64) -> isize {
    //pub struct TimeVal {
    //    sec: u64,
    //    usec: u64,
    //}
    let token = current_user_token();
    let us = get_time_us() as u64;
    let sec = us / USEC_PER_SEC as u64;
    let usec = us % USEC_PER_SEC as u64;
    *translated_refmut(token, ts) = sec;
    *translated_refmut(token, unsafe { ts.add(1) }) = usec;
    0
}

pub fn sys_get_times(tms: *mut u64) -> isize {
    let usec = get_time_us() as u64;
    let token = current_user_token();
    *translated_refmut(token, tms) = usec;
    *translated_refmut(token, unsafe { tms.add(1) }) = usec;
    *translated_refmut(token, unsafe { tms.add(2) }) = usec;
    *translated_refmut(token, unsafe { tms.add(3) }) = usec;

    usec as isize
}

pub fn sys_getpid() -> isize {
    current_process().getpid() as isize
}

pub fn sys_getppid() -> isize {
    current_process()
        .inner_exclusive_access()
        .parent
        .as_ref()
        .unwrap()
        .upgrade()
        .unwrap()
        .getpid() as isize
}

pub fn sys_fork() -> isize {
    let current_process = current_process();
    let new_process = current_process.fork();
    let new_pid = new_process.getpid();
    // modify trap context of new_task, because it returns immediately after switching
    let new_process_inner = new_process.inner_exclusive_access();
    let task = new_process_inner.tasks[0].as_ref().unwrap();
    let trap_cx = task.inner_exclusive_access().get_trap_cx();
    // we do not have to move to next instruction since we have done it before
    // for child process, fork returns 0
    trap_cx.x[10] = 0;
    new_pid as isize
}

pub fn sys_clone(flags: usize, stack_ptr: usize, ptid: usize, tls: usize, ctid: usize) -> isize {
    let token = current_user_token();
    let process = current_process();
    let task = current_task().unwrap();
    let flags = unsafe { CloneFlag::from_bits_unchecked(flags) };
    
    if flags.contains(CloneFlag::CLONE_THREAD) {
        let child_task = process.clone_thread(task);
        let child_tid = child_task.gettid();
        let mut child_task_inner = child_task.inner_exclusive_access();
        let child_trap_cx = child_task_inner.get_trap_cx();
        
        if flags.contains(CloneFlag::CLONE_PARENT_SETTID) && ptid as usize != 0 {
            *translated_refmut(token, ptid as *mut u32) = child_tid as u32;
        }
        if flags.contains(CloneFlag::CLONE_CHILD_CLEARTID) && ctid as usize != 0 {
            child_task_inner.clear_child_tid = Some(ClearChildTid {
                ctid: *translated_ref(token, ctid as *mut u32),
                addr: ctid,
            })
        }
        if flags.contains(CloneFlag::CLONE_SETTLS) {
            child_trap_cx.x[4] = tls;
        }

        if stack_ptr != 0 {
            child_trap_cx.x[2] = stack_ptr;
        }
        child_trap_cx.x[10] = 0;
        // println!("[clone] tid: {}, ctid: {}", current_task().unwrap().gettid(), child_tid);
        child_tid as isize
    } else {
        let child_process = process.fork();
        let mut child_process_inner = child_process.inner_exclusive_access();
        let child_task = child_process_inner.tasks[0].as_ref().unwrap();
        let mut child_task_inner = child_task.inner_exclusive_access();
        let child_pid = child_process.getpid();

        // if !flags.contains(CloneFlag::CLONE_SIGHLD) {
        //     return -1;
        // }
        if flags.contains(CloneFlag::CLONE_PARENT_SETTID) && ptid != 0 {
            *translated_refmut(process.inner_exclusive_access().get_user_token(), ptid as *mut u32) = child_pid as u32;
        }
        if flags.contains(CloneFlag::CLONE_CHILD_CLEARTID) && ctid != 0 {
            child_task_inner.clear_child_tid = Some(ClearChildTid {
                ctid: *translated_ref(token, ctid as *mut u32),
                addr: ctid as usize
            });
        }
        if flags.contains(CloneFlag::CLONE_CHILD_SETTID) {
            *translated_refmut(child_process_inner.get_user_token(), ctid as *mut u32) = child_pid as u32;
        }

        //更改用户栈
        let child_trap_cx = child_task_inner.get_trap_cx();
        if stack_ptr != 0 {
            child_trap_cx.x[2] = stack_ptr;
        }
        child_trap_cx.x[10] = 0;
        child_pid as isize
    }
}

pub fn sys_exec(path: *const u8, mut args: *const usize) -> isize {
    let token = current_user_token();
    let path = translated_str(token, path);
    let mut args_vec: Vec<String> = Vec::new();
    loop {
        let arg_str_ptr = *translated_ref(token, args);
        if arg_str_ptr == 0 {
            break;
        }
        args_vec.push(translated_str(token, arg_str_ptr as *const u8));
        unsafe {
            args = args.add(1);
        }
    }
    
    if !args_vec.contains(&path) {
        args_vec.insert(0, path.clone())
    }
    
    //获取当前工作目录
    let work_path = current_process()
        .inner_exclusive_access()
        .work_path
        .to_string();
    
    let process = current_process();
    match path.as_str() {
        "runtest.exe" => {
            let data_lock = TEST_SH_DATA.exclusive_access();
            let data = data_lock.as_slice();
            process.exec(data, args_vec);
            0
        }
        "entry-static.exe" => {
            let data_lock = ENTRY_STATIC_DATA.exclusive_access();
            let data = data_lock.as_slice();
            process.exec(data, args_vec);
            0
        }
        _ => {
            if let Some(app_inode) = open_file(
                &work_path,
                path.as_str(),
                OpenFlags::RDONLY,
                FileType::Regular,
            ) {
                let all_data = app_inode.read_all();
                process.exec(&all_data, args_vec);
    
                // return argc because cx.x[10] will be covered with it later
                0
            } else {
                -1
            }
        }
    }
}

/// If there is not a child process whose pid is same as given, return -1.
/// Else if there is a child process but it is still running, return -2.
pub fn sys_waitpid(pid: isize, exit_code_ptr: *mut i32) -> isize {
    loop {
        let mut found = true;
        let mut exited = true;
        {
            let process = current_process();
            let mut inner = process.inner_exclusive_access();
            let token = inner.get_user_token();

            if !inner
                .children
                .iter()
                .any(|p| pid == -1 || pid as usize == p.getpid())
            {
                found = false;
                // ---- release current PCB
            }

            if found {
                let pair = inner.children.iter().enumerate().find(|(_, p)| {
                    // println!("{}", color!(format!("[waitpid] wait pid: 3"), WARNING));
                    let child_pid = p.getpid();
                    let inner = p.inner_exclusive_access();
                    let flag = inner.is_zombie && (pid == -1 || pid as usize == child_pid);
                    drop(inner);
                    flag
                });

                if let Some((idx, _)) = pair {
                    let child = inner.children.remove(idx);
                    assert_eq!(Arc::strong_count(&child), 1);
                    let found_pid = child.getpid();
                    let exit_code = child.inner_exclusive_access().exit_code;
    
                    if exit_code_ptr as usize != 0 {
                        *translated_refmut(token, exit_code_ptr) = (exit_code & 0xff) << 8;
                    }
                    return found_pid as isize;
                } else {
                    exited = false
                }
            }
        }
        assert!(!found || !exited);
        suspend_current_and_run_next();
    
        //let process = current_process();
        //// find a child process
        //
        //let mut inner = process.inner_exclusive_access();
        //if !inner
        //    .children
        //    .iter()
        //    .any(|p| pid == -1 || pid as usize == p.getpid())
        //{
        //    return -1;
        //    // ---- release current PCB
        //}
        //let pair = inner.children.iter().enumerate().find(|(_, p)| {
        //    // ++++ temporarily access child PCB exclusively
        //    let child_pid = p.getpid();
        //    p.inner_exclusive_access().is_zombie && (pid == -1 || pid as usize == child_pid)
        //    // ++++ release child PCB
        //});
        //if let Some((idx, _)) = pair {
        //    let child = inner.children.remove(idx);
        //    // confirm that child will be deallocated after being removed from children list
        //    assert_eq!(Arc::strong_count(&child), 1);
        //    let found_pid = child.getpid();
        //    // ++++ temporarily access child PCB exclusively
        //    let exit_code = child.inner_exclusive_access().exit_code;
        //    // ++++ release child PCB
        //    if (exit_code_ptr as usize) != 0 {
        //        *translated_refmut(inner.memory_set.token(), exit_code_ptr) = exit_code << 8;
        //        //不太清楚为什么需要左移8位
        //    }
        //    return found_pid as isize;
        //} else {
        //    drop(inner);
        //    drop(process);
        //    suspend_current_and_run_next();
        //}
    }
    // ---- release current PCB automatically
}

pub fn sys_kill(pid: usize, signal: u64) -> isize {
    if let Some(process) = pid2process(pid) {
        if let Some(flag) = Signum::from_bits(1 << signal) {
            // 向主线程发送signal
            let process_inner = process.inner_exclusive_access();
            let task = process_inner.tasks[0].as_ref().unwrap();
            task.inner_exclusive_access().signals |= flag;
            0
        } else {
            -1
        }
    } else {
        -1
    }
}

pub fn sys_tkill(tid: usize, signal: usize) -> isize {
    // println!("[tkill] tid:{}, target_tid: {}, signal: {:#X}", current_task().unwrap().gettid(), tid, signal);
    if let Some(task) = tid2task(tid) {
        if let Some(flag) = Signum::from_bits(1 << signal) {
            task.inner_exclusive_access().signals |= flag;
            0
        } else {
            -1
        }
    } else {
        -1
    }
}

pub fn sys_brk(addr: usize) -> isize {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    if addr == 0 {
        inner.heap_end.0 as isize
    } else if addr < inner.heap_base.0 {
        -1
    } else {
        let mut old_end = inner.heap_end.0;
        let align_end = align_up(addr);
        inner.heap_end = align_end.into();

        // remove lazy
        loop {
            if old_end >= align_end {
                break;
            }
            inner.memory_set.lazy_alloc_heap(VirtAddr::from(old_end));
            old_end += PAGE_SIZE;
        }
        addr as isize
    }
}

pub fn sys_mmap(
    start: usize,
    len: usize,
    prot: usize,
    flags: usize,
    fd: usize,
    offset: usize,
) -> isize {
    let token = current_user_token();
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    let align_start = if start != 0 && flags & MAP_FIXED != 0 {
        align_up(start)
    } else {
        align_up(inner.mmap_area_end.0)
    };
    let align_len = align_up(len);
    let adjust_fd = if fd as isize == -1 {
        inner.alloc_fd()
    } else if flags & MAP_ANONYMOUS != 0 {
        inner.alloc_specific_fd(fd)
    } else {
        fd
    };
    // println!(
    //     "[mmap] start: {:#X}, len: {:#X}, flag: {:#X}",
    //     align_start, align_len, flags
    // );
    drop(inner);
    process.mmap(align_start, align_len, prot, flags, adjust_fd, offset);
    align_start as isize
}

pub fn sys_munmap(start: usize, len: usize) -> isize {
    let align_start = align_up(start);
    if current_process().munmap(align_start, len) {
        0
    } else {
        -1
    }
}

// pub fn sys_mprotect(addr: usize, len: usize, prot: usize) -> isize {
//     if addr == 0 || addr % PAGE_SIZE != 0 {// addr对齐到页面
//         -1
//     } else {
//         // current_process()
//         //     .inner_exclusive_access()
//         //     .mprotect(addr, align_up(len), prot);
//         let process = current_process();
//         let mut inner = process.inner_exclusive_access();
//         let flag = PTEFlags::from_bits((prot as u8) << 1).unwrap();
//         let mut curr_addr = addr;
//         loop {
//             if curr_addr >= addr + len {
//                 break;
//             }
//             let vpn = VirtPageNum::from(VirtAddr::from(curr_addr));
//             if !inner.memory_set.set_pte_flags(vpn, flag) {
//                 return -1;
//             }
//             curr_addr += PAGE_SIZE;
//         }
//         0
//     }
// }

//that's only root user
pub fn sys_get_uid() -> isize {
    0
}

pub fn sys_get_euid() -> isize {
    0
}

pub fn sys_set_tid_address(tid_ptr: usize) -> isize {
    let token = current_user_token();
    let task = current_task().unwrap();
    let task_inner = task.inner_exclusive_access();

    let ctid = if let Some(p) = &task_inner.clear_child_tid {
        p.ctid
    } else {
        0
    };
    *translated_refmut(token, tid_ptr as *mut u32) = ctid;
    task_inner.gettid() as isize
}

pub fn sys_sigaction(signum: usize, act: *mut usize, oldact: *mut usize) -> isize {
    if let Some(s) = Signum::from_bits(1 << signum) {
        if [Signum::SIGKILL, Signum::SIGSTOP].contains(&s) {
            return -1;
        }
    } else {
        return -1;
    };

    let act = act as *mut SigAction;
    let oldact = oldact as *mut SigAction;

    let token = current_user_token();
    let task = current_task().unwrap();
    let mut task_inner = task.inner_exclusive_access();
    let process = current_process();
    let mut process_inner = process.inner_exclusive_access();

    // 将原来的sigaction保存到oldact地址中
    if let Some(old_sigaction) = process_inner.signal_actions.actions[signum] {
        if oldact as usize != 0 {
            *translated_refmut(token, oldact) = old_sigaction;
        }
        process_inner.signal_actions.actions[signum] = None;
    } else if oldact as usize != 0 {
        *translated_refmut(token, oldact) = SigAction::default();
    }

    // 保存新的sigaction
    if act as usize != 0 {
        let sigaction = *translated_ref(token, act);
        drop(task_inner);
        // println!("[sigaction] tid: {} sigaction: {:#X}, signum: {}", task.gettid(), sigaction.sa_handler, signum);
        process_inner.signal_actions.actions[signum] = Some(sigaction);
    }

    0
}

pub fn sys_sigprocmask(how: usize, set: *mut u64, old_set: *mut u64) -> isize {
    let token = current_user_token();
    let task = current_task().unwrap();
    let mut inner = task.inner_exclusive_access();
    let mut mask = inner.signal_masks.bits();

    if old_set as usize != 0 {
        *translated_refmut(token, old_set) = mask;
    }

    if set as usize != 0 {
        let new_set = *translated_ref(token, set);
        match how {
            // SIG_BLOCK The set of blocked signals is the union of the current set and the set argument.
            SIG_BLOCK => mask |= new_set,
            // SIG_UNBLOCK The signals in set are removed from the current set of blocked signals.
            SIG_UNBLOCK => mask &= !new_set,
            // SIG_SETMASK The set of blocked signals is set to the argument set.
            SIG_SETMASK => mask = new_set,
            _ => return -1,
        }
        inner.signal_masks = Signum::from_bits(mask & ((1 << MAX_SIG) - 1)).unwrap();
    }
    0
}

pub fn sys_sigtimedwait(set: *mut u64, info: *mut usize, timeout: *mut usize) -> isize {
    if set as usize == 0 {
        return -1;
    }

    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    let token = inner.get_user_token();

    if timeout as usize == 0 {
        return -1;
    }
    let timeout = translated_refmut(token, timeout as *mut TimeSpec).to_nsec();

    let info = (info as usize != 0).then_some(translated_refmut(token, info as *mut SigInfo));

    let start = get_time_ns();
    while *translated_refmut(token, set) == 0 {
        let now = get_time_ns();
        if now - start >= timeout {
            return -1;
        }
    }

    let set = Signum::from_bits(*translated_refmut(token, set) as u64).unwrap();

    for serial in 1..MAX_SIG {
        if set.contains(Signum::from_serial(serial).unwrap()) {
            if let Some(info) = info {
                info.signo = serial as i32;
                // TODO si_code
                // TODO si_value
            }
            return serial as isize;
        }
    }

    -1
}

pub fn sys_sigreturn() -> isize {
    let token = current_user_token();
    let task = current_task().unwrap();
    let tid = task.gettid();
    let mut task_inner = task.inner_exclusive_access();

    // 取消当前正在响应的信号
    task_inner.signal_handling = 0;

    // 将备份的trap上下文恢复
    let trap_cx = task_inner.get_trap_cx();
    let mc_pc_ptr = trap_cx.x[2] + UContext::pc_offset();
    let mc_pc = *translated_ref(token, mc_pc_ptr as *mut u64) as usize;
    *trap_cx = task_inner.trap_ctx_backup.unwrap();
    trap_cx.sepc = mc_pc;
    
    // println!("[sigreturn] tid: {}, new_pc: {:#X}", tid, trap_cx.sepc);

    0
}

pub fn sys_getitimer(which: isize, curr_value: usize) -> isize {
    // 决赛只需实现 which == ITIMER_REAL
    if curr_value != 0 {
        let token = current_user_token();
        // 将 itimer 写入到 curr_value 指向的地址中
        let itimer = current_process().inner_exclusive_access().itimer;
        let mut buf = UserBuffer::new(translated_byte_buffer(
            token,
            curr_value as *const u8,
            size_of::<ITimerVal>(),
        ));
        buf.write(itimer.as_bytes());
        0
    } else {
        -1
    }
}

pub fn sys_setitimer(which: isize, new_value: *mut usize, old_value: usize) -> isize {
    // 决赛只需实现 which == ITIMER_REAL
    // struct itimerval {
    //     struct timeval it_interval; /* next value */
    //     struct timeval it_value;    /* current value */
    // };
    // struct timeval {
    //     time_t      tv_sec;         /* seconds */
    //     suseconds_t tv_usec;        /* microseconds */
    // };
    if new_value as usize != 0 {
        let token = current_user_token();
        // 将原本的itimer写入old_value
        if old_value as usize != 0 {
            let itimer = current_process().inner_exclusive_access().itimer;
            let mut buf = UserBuffer::new(translated_byte_buffer(
                token,
                old_value as *const u8,
                size_of::<ITimerVal>(),
            ));
            buf.write(itimer.as_bytes());
        }
        // new_value写入新的itimer
        let mut new_itimer = ITimerVal::new();
        new_itimer.it_interval.tv_sec = *translated_refmut(token, new_value);
        new_itimer.it_interval.tv_usec = *translated_refmut(token, unsafe { new_value.add(1) });
        new_itimer.it_value.tv_sec = *translated_refmut(token, unsafe { new_value.add(2) });
        new_itimer.it_value.tv_usec = *translated_refmut(token, unsafe { new_value.add(3) });
        current_process().inner_exclusive_access().itimer = new_itimer;
        // 插入到itimer向量中，开始计时
        ITIMER_MANAGER
            .exclusive_access()
            .insert_itimer(new_itimer, current_process().getpid());
        0
    } else {
        -1
    }
}

pub fn sys_clock_gettime(clk_id: isize, tp: *mut usize) -> isize {
    // 当前只支持 clk_id == CLOCK_REALTIME
    // struct timespec {
    //     time_t   tv_sec;        /* seconds */
    //     long     tv_nsec;       /* nanoseconds */
    // };
    if tp as usize != 0 {
        let token = current_user_token();
        let ticks = get_time();
        *translated_refmut(token, tp) = ticks / CLOCK_FREQ;
        *translated_refmut(token, unsafe { tp.add(1) }) =
            ticks % CLOCK_FREQ * (NSEC_PER_SEC / CLOCK_FREQ);
        0
    } else {
        -1
    }
}

pub fn sys_mprotect(addr: usize, len: usize, prot: isize) -> isize {
    if addr % PAGE_SIZE != 0 || len % PAGE_SIZE != 0 {
        return -1;
    }
    let pcb = current_process();
    let memory_set = &mut pcb.inner_exclusive_access().memory_set;
    
    let start_vpn = addr / PAGE_SIZE;
    for i in 0..(len / PAGE_SIZE) {
        let vpn = start_vpn + i;
        if memory_set.set_mem_flags(VirtPageNum::from(vpn), prot as usize) == -1 {
            return -1;
        }
    }
    0
}

#[derive(Clone, Copy, Debug)]
pub struct RLimit64 {
    pub rlim_cur: usize,
    pub rlim_max: usize,
}

pub fn sys_prlimit(
    pid: usize,
    resource: usize,
    rlimit: *const RLimit64,
    old_rlimit: *mut RLimit64,
) -> isize {
    let token = current_user_token();
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    match resource {
        RLIMIT_NOFILE => {
            // 仅仅记录值到inner.fd_max
            if old_rlimit as usize != 0 && inner.fd_max != FD_MAX {
                let _old_rlimit = translated_refmut(token, old_rlimit);
                _old_rlimit.rlim_cur = inner.fd_max + 1;
                _old_rlimit.rlim_max = inner.fd_max + 1;
            }
            if rlimit as usize != 0 {
                let _rlimit = translated_ref(token, rlimit);
                inner.fd_max = _rlimit.rlim_max - 1;
            }
            0
        }
        _ => {
            // println!("{}", color!(format!("sys_prlimit() unsupport resource:{}", resource), WARNING));
            0
        }
    }
}
