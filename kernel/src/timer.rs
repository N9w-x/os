use alloc::collections::BinaryHeap;
use alloc::sync::Arc;
use core::cmp::Ordering;

use lazy_static::*;
use riscv::register::time;
use spin::Mutex;

use crate::config::CLOCK_FREQ;
use crate::sbi::set_timer;
use crate::task::{add_task, TaskControlBlock};

pub const TICKS_PER_SEC: usize = 100;
pub const MSEC_PER_SEC: usize = 1000;
pub const USEC_PER_SEC: usize = 1000_000;
pub const NSEC_PER_SEC: usize = 1000_000_000;

pub fn get_time() -> usize {
    time::read()
}

pub fn get_time_ms() -> usize {
    time::read() / (CLOCK_FREQ / MSEC_PER_SEC)
}

pub fn get_time_us() -> usize {
    time::read() / (CLOCK_FREQ / (USEC_PER_SEC / 10)) * 10 // 防止整除导致小数部分丢失
}

pub fn get_time_ns() -> usize {
    time::read() / (CLOCK_FREQ / (NSEC_PER_SEC / 1000)) * 1000
}

pub fn set_next_trigger() {
    set_timer(get_time() + CLOCK_FREQ / TICKS_PER_SEC);
}
