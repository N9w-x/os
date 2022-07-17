use core::mem::size_of;

use alloc::format;
use alloc::string::{String, ToString};
use alloc::sync::Arc;
use alloc::vec::Vec;

use crate::config::CLOCK_FREQ;
use crate::console::INFO;
use crate::fs_fat::{FileType, open_file, OpenFlags};
use crate::mm::{align_up, translated_ref, translated_refmut, translated_str, translated_byte_buffer, UserBuffer};
use crate::syscall::thread::sys_gettid;
use crate::task::{
    add_task, current_process, current_task, current_user_token, exit_current_and_run_next, 
    pid2process, suspend_current_and_run_next, CloneFlag, Signum, SigAction, ITimerVal, ITIMER_MANAGER,
};
use crate::timer::{get_time, get_time_ms, get_time_us, USEC_PER_SEC, NSEC_PER_SEC};
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
    let pcb = current_process();
    let flags = unsafe { CloneFlag::from_bits_unchecked(flags) };
    let child_pcb = pcb.fork();
    let mut child_inner = child_pcb.inner_exclusive_access();
    let child_pid = child_pcb.getpid();

    if !flags.contains(CloneFlag::CLONE_SIGHLD) {
        return -1;
    }
    if flags.contains(CloneFlag::CLONE_CHILD_CLEARTID) {
        child_inner.tid_attr.clear_child_tid = ctid;
    }
    if flags.contains(CloneFlag::CLONE_CHILD_SETTID) {
        child_inner.tid_attr.set_child_tid = ctid;
    }

    let child_task = child_inner.tasks[0].as_ref().unwrap();
    let child_trap_cx = child_task.inner.exclusive_access().get_trap_cx();

    //更改用户栈
    if stack_ptr != 0 {
        child_trap_cx.x[2] = stack_ptr;
    }
    child_trap_cx.x[10] = 0;
    child_pid as isize
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

    //获取当前工作目录
    let work_path = current_process()
        .inner_exclusive_access()
        .work_path
        .to_string();
    if let Some(app_inode) = open_file(
        &work_path,
        path.as_str(),
        OpenFlags::RDONLY,
        FileType::Regular,
    ) {
        let all_data = app_inode.read_all();
        let process = current_process();
        let argc = args_vec.len();
        process.exec(all_data.as_slice(), args_vec);
        // return argc because cx.x[10] will be covered with it later
        argc as isize
    } else {
        -1
    }
}

/// If there is not a child process whose pid is same as given, return -1.
/// Else if there is a child process but it is still running, return -2.
pub fn sys_waitpid(pid: isize, exit_code_ptr: *mut i32) -> isize {
    loop {
        let process = current_process();
        // find a child process

        let mut inner = process.inner_exclusive_access();
        if !inner
            .children
            .iter()
            .any(|p| pid == -1 || pid as usize == p.getpid())
        {
            return -1;
            // ---- release current PCB
        }
        let pair = inner.children.iter().enumerate().find(|(_, p)| {
            // ++++ temporarily access child PCB exclusively
            p.inner_exclusive_access().is_zombie && (pid == -1 || pid as usize == p.getpid())
            // ++++ release child PCB
        });
        if let Some((idx, _)) = pair {
            let child = inner.children.remove(idx);
            // confirm that child will be deallocated after being removed from children list
            assert_eq!(Arc::strong_count(&child), 1);
            let found_pid = child.getpid();
            // ++++ temporarily access child PCB exclusively
            let exit_code = child.inner_exclusive_access().exit_code;
            // ++++ release child PCB
            if (exit_code_ptr as usize) != 0 {
                *translated_refmut(inner.memory_set.token(), exit_code_ptr) = exit_code << 8;
                //不太清楚为什么需要左移8位
            }
            return found_pid as isize;
        } else {
            drop(inner);
            drop(process);
            suspend_current_and_run_next();
        }
    }
    // ---- release current PCB automatically
}

pub fn sys_kill(pid: usize, signal: u32) -> isize {
    if let Some(process) = pid2process(pid) {
        if let Some(flag) = Signum::from_bits(signal) {
            process.inner_exclusive_access().signals |= flag;
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
        inner.heap_end = addr.into();
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
    let align_start = align_up(current_process().inner_exclusive_access().mmap_area_end.0);
    let align_len = align_up(len);
    current_process().inner_exclusive_access().mmap(
        align_start,
        align_len,
        prot,
        flags,
        fd,
        offset,
    );
    lazy_check(align_start);
    align_start as isize
}

pub fn sys_munmap(start: usize, len: usize) -> isize {
    let align_start = align_up(start);
    if current_process()
        .inner_exclusive_access()
        .munmap(align_start, len)
    {
        0
    } else {
        -1
    }
}

//that's only root user
pub fn sys_get_uid() -> isize {
    0
}

pub fn sys_get_euid() -> isize {
    0
}

pub fn sys_set_tid_address(tid_ptr: usize) -> isize {
    current_process()
        .inner_exclusive_access()
        .tid_attr
        .clear_child_tid = tid_ptr;
    sys_gettid()
}

pub fn sys_sigaction(signum: usize, act: *mut usize, oldact: *mut usize) -> isize {
    if let Some(s) = Signum::from_serial(signum) {
        if [Signum::SIGKILL, Signum::SIGSTOP].contains(&s) {
            return -1;
        }
    } else {
        return -1;
    };

    let act = act as *mut SigAction;
    let oldact = oldact as *mut SigAction;

    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    let token = current_user_token();

    // 将原来的sigaction保存到oldact地址中
    if let Some(old_sigaction) = inner.signal_actions.actions[signum] {
        if oldact as usize != 0 {
            *translated_refmut(token, oldact) = old_sigaction;
        }
        inner.signal_actions.actions[signum] = None;
    } else if oldact as usize != 0 {
        *translated_refmut(token, oldact) = SigAction::default();
    }

    // 保存新的sigaction
    if act as usize != 0 {
        let sigaction = *translated_ref(token, act);
        inner.signal_actions.actions[signum] = Some(sigaction);
    }

    0
}

pub fn sys_sigreturn() -> isize {
    let task = current_task().unwrap();
    let process = task.process.upgrade().unwrap();

    let mut process_inner = process.inner_exclusive_access();
    let mut inner = task.inner_exclusive_access();

    // 取消当前正在响应的信号
    process_inner.signal_handling = 0;

    // 将备份的trap上下文恢复
    *inner.get_trap_cx() = process_inner.trap_ctx_backup.unwrap();

    0
}

pub fn sys_sigprocmask(mask: u32) -> isize {
    todo!();
    1
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
            size_of::<ITimerVal>()
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
                size_of::<ITimerVal>()
            ));
            buf.write(itimer.as_bytes());
        }
        // new_value写入新的itimer
        let mut new_itimer = ITimerVal::new();
        new_itimer.it_interval.tv_sec = *translated_refmut(token, new_value);
        new_itimer.it_interval.tv_usec = *translated_refmut(token, unsafe {new_value.add(1)});
        new_itimer.it_value.tv_sec = *translated_refmut(token, unsafe {new_value.add(2)});
        new_itimer.it_value.tv_usec = *translated_refmut(token, unsafe {new_value.add(3)});
        current_process().inner_exclusive_access().itimer = new_itimer;
        // 插入到itimer向量中，开始计时
        ITIMER_MANAGER.exclusive_access().insert_itimer(new_itimer, current_process().getpid());
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
