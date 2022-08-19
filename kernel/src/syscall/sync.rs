use alloc::sync::Arc;

use crate::config::CLOCK_FREQ;
use crate::mm::{translated_ref, translated_refmut};
use crate::task::{
    block_current_and_run_next, current_process, current_task, current_user_token, futex_requeue,
    futex_wait, futex_wake, suspend_current_and_run_next,
};
use crate::task::{FUTEX_CLOCK_REALTIME, FUTEX_OP_MASK, FUTEX_REQUEUE, FUTEX_WAIT, FUTEX_WAKE};
use crate::timer::{get_time, get_time_ms, get_time_us, MSEC_PER_SEC, NSEC_PER_SEC};

pub fn sys_sleep(time_req: *const u64, time_remain: *mut u64) -> isize {
    #[inline]
    fn is_end(end_time: usize) -> bool {
        let current_time = get_time();
        current_time >= end_time
    }
    
    let token = current_user_token();
    let sec = *translated_ref(token, time_req);
    let nano_sec = *translated_ref(token, unsafe { time_req.add(1) });
    let end_time =
        get_time() + sec as usize * CLOCK_FREQ + nano_sec as usize * CLOCK_FREQ / NSEC_PER_SEC;
    
    loop {
        if is_end(end_time) {
            break;
        } else {
            suspend_current_and_run_next();
        }
    }
    
    if time_remain as usize != 0 {
        *translated_refmut(token, time_remain) = 0;
        *translated_refmut(token, unsafe { time_remain.add(1) }) = 0;
    }
    0
}

pub fn sys_futex(
    uaddr: usize,
    op: usize,
    val: usize,
    timeout: usize,
    uaddr2: usize,
    val3: usize,
) -> isize {
    if op & FUTEX_CLOCK_REALTIME != 0 && op & FUTEX_OP_MASK != FUTEX_WAIT {
        return -1;
    }
    
    let op = op & FUTEX_OP_MASK;
    // println!("[futex] tid: {}, op: {:#X}, uaddr: {:#X}, val: {}", current_task().unwrap().gettid(), op, uaddr, val as isize);
    let a = match op {
        FUTEX_WAIT => {
            // println!("[futex] wait");
            futex_wait(uaddr, val, 0) as isize
        }
        FUTEX_WAKE => {
            // println!("[futex] wake");
            futex_wake(uaddr, val) as isize
        }
        FUTEX_REQUEUE => {
            // println!("[futex] requeue");
            futex_requeue(uaddr, val, uaddr2) as isize
        }
        _ => {
            unimplemented!("unsupported futex op: {:#x}", op);
        }
    };
    // println!("[futex] ret: {}", a);
    a
}
