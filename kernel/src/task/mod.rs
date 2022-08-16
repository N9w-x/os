use alloc::sync::Arc;
use alloc::vec::Vec;
use core::slice::from_raw_parts;

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

pub fn suspend_current_and_run_next() -> isize {
    // There must be an application running.
    let task = take_current_task().unwrap();
    if task
        .inner_exclusive_access()
        .signals
        .contains(Signum::SIGKILL)
    {
        drop(task);
        //exit_current_and_run_next(-9 as i32, false);
        return -1;
    }
    
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
    0
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

pub fn exit_current_and_run_next(exit_code: i32, is_exit_group: bool) {
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
    if id == 0 || is_exit_group {
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
    // 直接加载user_shell, 不再加载initproc
    pub static ref INITPROC: Arc<ProcessControlBlock> = {
        //* 如果先从内存中加载initproc, 需要解注: */
        //* sys_exec中还有一处需要解注 */
        // extern "C" {
        //     fn app_0_start();
        //     fn app_0_end();
        // }
        // unsafe {
        //     ProcessControlBlock::new(from_raw_parts(
        //         app_0_start as *const u8,
        //         app_0_end as usize - app_0_start as usize,
        //     ))
        // }
        extern "C" {
            fn app_1_start();
            fn app_1_end();
        }
        unsafe {
            ProcessControlBlock::new(from_raw_parts(
                app_1_start as *const u8,
                app_1_end as usize - app_1_start as usize,
            ))
        }
    };
}

pub fn add_initproc() {
    let _initproc = INITPROC.clone();
}

// 这里释放的内存在运行期间不会被用到，因此不如不释放
// pub fn add_initproc_into_fs() {
//     extern "C" {
//         fn _num_app();
//     }
//     extern "C" {
//         fn _app_names();
//     }
//     let mut num_app_ptr = _num_app as usize as *mut usize;
//     // let start = _app_names as usize as *const u8;
//     let mut app_start = unsafe { core::slice::from_raw_parts_mut(num_app_ptr.add(1), 3) };

//     // release
//     let mut start_ppn = app_start[0] / PAGE_SIZE + 1;
//     println!(
//         "Recycle memory: {:x}-{:x}",
//         start_ppn * PAGE_SIZE,
//         (app_start[2] / PAGE_SIZE) * PAGE_SIZE
//     );
//     while start_ppn < app_start[2] / PAGE_SIZE {
//         add_free(start_ppn);
//         start_ppn += 1;
//     }
// }

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
