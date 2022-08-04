use alloc::sync::Arc;
use alloc::vec::Vec;

use lazy_static::*;

//pub use cache::{ENTRY_STATIC_DATA, TEST_SH_DATA};
pub use context::TaskContext;
pub use futex::*;
pub use id::{KernelStack, kstack_alloc, pid_alloc, PidHandle};
pub use info::CloneFlag;
pub use manager::{
    add_task, fetch_task, pid2process, remove_from_pid2process, remove_from_tid2task, tid2task,
};
use process::ProcessControlBlock;
pub use processor::{
    current_kstack_top, current_process, current_task, current_trap_cx, current_trap_cx_user_va,
    current_user_token, run_tasks, schedule, take_current_task,
};
pub use signal::*;
use switch::__switch;
pub use task::{ClearChildTid, TaskControlBlock, TaskStatus};
pub use timer::{ITIMER_MANAGER, ITimerVal, TimeSpec, TimeVal, UTIME_NOW, UTIME_OMIT};

use crate::config::PAGE_SIZE;
use crate::fs::{File, FileType, open_file, OpenFlags, OSInode};
use crate::mm::{add_free, translated_refmut, UserBuffer};

mod context;
mod futex;
mod id;
mod info;
mod manager;
mod process;
mod processor;
mod signal;
mod switch;
#[allow(clippy::module_inception)]
mod task;
mod timer;

pub fn suspend_current_and_run_next() {
    // There must be an application running.
    let task = take_current_task().unwrap();
    
    // ---- access current TCB exclusively
    let mut task_inner = task.inner_exclusive_access();
    let task_cx_ptr = &mut task_inner.task_cx as *mut TaskContext;
    // Change status to Ready
    task_inner.task_status = TaskStatus::Ready;
    drop(task_inner);
    // ---- release current TCB
    
    // push back to ready queue.
    add_task(task);
    // jump to scheduling cycle
    schedule(task_cx_ptr);
}

/// This function must be followed by a schedule
pub fn block_current_task() -> *mut TaskContext {
    let task = take_current_task().unwrap();
    let mut task_inner = task.inner_exclusive_access();
    task_inner.task_status = TaskStatus::Blocking;
    &mut task_inner.task_cx as *mut TaskContext
}

pub fn block_current_and_run_next() {
    let task = current_task().unwrap();
    let mut inner = task.inner_exclusive_access();
    let task_cx_ptr = &mut inner.task_cx as *mut TaskContext;
    inner.task_status = TaskStatus::Blocking;
    drop(inner);
    drop(task);
    schedule(task_cx_ptr);
}

pub fn unblock_task(task: Arc<TaskControlBlock>) {
    let mut inner = task.inner_exclusive_access();
    assert!(inner.task_status == TaskStatus::Blocking);
    inner.task_status = TaskStatus::Ready;
    drop(inner);
    add_task(task);
}

pub fn exit_current_and_run_next(exit_code: i32) {
    let token = current_user_token();
    let task = take_current_task().unwrap();
    let tid = task.gettid();
    let mut task_inner = task.inner_exclusive_access();
    let process = task.process.upgrade().unwrap();
    let id = task_inner.res.as_ref().unwrap().id;
    
    if task_inner.clear_child_tid != 0 {
        *translated_refmut(token, task_inner.clear_child_tid as *mut u32) = 0;
        futex_wake(task_inner.clear_child_tid, 1);
    }
    remove_from_tid2task(tid);
    
    // record exit code
    task_inner.exit_code = Some(exit_code);
    task_inner.res = None;
    // here we do not remove the thread since we are still using the kstack
    // it will be deallocated when sys_waittid is called
    drop(task_inner);
    drop(task);
    // however, if this is the main thread of current process
    // the process should terminate at once
    if id == 0 {
        remove_from_pid2process(process.getpid());
        let mut process_inner = process.inner_exclusive_access();
        // mark this process as a zombie process
        process_inner.is_zombie = true;
        // record exit code of main process
        process_inner.exit_code = exit_code;
    
        {
            // move all child processes under init process
            let mut initproc_inner = INITPROC.inner_exclusive_access();
            for child in process_inner.children.iter() {
                child.inner_exclusive_access().parent = Some(Arc::downgrade(&INITPROC));
                initproc_inner.children.push(child.clone());
            }
        }
    
        // deallocate user res (including tid/trap_cx/ustack) of all threads
        // it has to be done before we dealloc the whole memory_set
        // otherwise they will be deallocated twice
        for task in process_inner.tasks.iter().filter(|t| t.is_some()) {
            let task = task.as_ref().unwrap();
            let mut task_inner = task.inner_exclusive_access();
            task_inner.res = None;
        }
    
        process_inner.children.clear();
        // deallocate other data in user space i.e. program code/data section
        process_inner.memory_set.recycle_data_pages();
        // drop file descriptors
        process_inner.fd_table.clear();
    }
    // 定时器停止计时
    ITIMER_MANAGER.lock().remove_itimer(process.getpid());
    drop(process);
    // we do not have to save task context
    let mut _unused = TaskContext::zero_init();
    schedule(&mut _unused as *mut _);
}

lazy_static! {
    pub static ref INITPROC: Arc<ProcessControlBlock> = {
        let inode = open_file("/", "initproc", OpenFlags::RDONLY, FileType::Regular).unwrap();
        let v = inode.read_all();
        ProcessControlBlock::new(v.as_slice())
    };
}

pub fn add_initproc() {
    add_initproc_into_fs();
    let _initproc = INITPROC.clone();
}

pub fn add_initproc_into_fs() {
    extern "C" {
        fn _num_app();
    }
    extern "C" {
        fn _app_names();
    }
    let mut num_app_ptr = _num_app as usize as *mut usize;
    // let start = _app_names as usize as *const u8;
    let mut app_start = unsafe { core::slice::from_raw_parts_mut(num_app_ptr.add(1), 3) };
    
    open_file("/", "mnt", OpenFlags::CREATE, FileType::Dir);
    open_file("/", "tmp", OpenFlags::CREATE, FileType::Dir);
    
    // find if there already exits
    // println!("Find if there already exits ");
    //if let Some(inode) = open_file("/", "initproc", OpenFlags::RDONLY, FileType::Normal) {
    //    println!("Already have init proc in FS");
    //    //return;
    //    inode.delete();
    //}
    //
    //if let Some(inode) = open_file("/", "user_shell", OpenFlags::RDONLY, FileType::Normal) {
    //    println!("Already have user shell in FS");
    //    //return;
    //    inode.delete();
    //}
    
    // println!("Write apps(initproc & user_shell) to disk from mem ");
    
    //Write apps(initproc & user_shell) to disk from mem
    match open_file("/", "initproc", OpenFlags::CREATE, FileType::Regular) {
        None => panic!("initproc create fail!"),
        Some(inode) => {
            // println!("Create initproc ");
            let mut data: Vec<&'static mut [u8]> = Vec::new();
            data.push(unsafe {
                core::slice::from_raw_parts_mut(
                    app_start[0] as *mut u8,
                    app_start[1] - app_start[0],
                )
            });
            // println!("Start write initproc ");
            inode.write(UserBuffer::new(data));
            // println!("Init_proc OK");
        }
    }
    
    match open_file("/", "user_shell", OpenFlags::CREATE, FileType::Regular) {
        None => panic!("user_shell create fail!"),
        Some(inode) => {
            // println!("Create user_shell ");
            let mut data: Vec<&'static mut [u8]> = Vec::new();
            data.push(unsafe {
                core::slice::from_raw_parts_mut(
                    app_start[1] as *mut u8,
                    app_start[2] - app_start[1],
                )
            });
            //data.extend_from_slice(  )
            // println!("Start write user_shell ");
            inode.write(UserBuffer::new(data));
            // println!("User_shell OK");
        }
    }
    // println!("Write apps(initproc & user_shell) to disk from mem");
    
    // release
    let mut start_ppn = app_start[0] / PAGE_SIZE + 1;
    println!(
        "Recycle memory: {:x}-{:x}",
        start_ppn * PAGE_SIZE,
        (app_start[2] / PAGE_SIZE) * PAGE_SIZE
    );
    while start_ppn < app_start[2] / PAGE_SIZE {
        add_free(start_ppn);
        start_ppn += 1;
    }
}

pub fn check_signals_of_current() -> Option<(i32, &'static str)> {
    // let process = current_process();
    // let process_inner = process.inner_exclusive_access();
    // process_inner.signals.check_error()
    let task = current_task().unwrap();
    let task_inner = task.inner_exclusive_access();
    task_inner.signals.check_error()
}

pub fn current_add_signal(signal: Signum) {
    // let process = current_process();
    // let mut process_inner = process.inner_exclusive_access();
    // process_inner.signals |= signal;
    let task = current_task().unwrap();
    let mut task_inner = task.inner_exclusive_access();
    task_inner.signals |= signal;
}

pub fn save_hart_id() {
    unsafe {
        core::arch::asm!("mv tp,a0");
    }
}

pub fn get_hart_id() -> usize {
    let hart_id;
    unsafe {
        core::arch::asm!(
        "mv {}, tp",
        out(reg) hart_id
        );
    }
    hart_id
}
