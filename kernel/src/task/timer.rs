use alloc::{collections::BTreeMap, vec::Vec};
use core::cmp::max;
use lazy_static::*;

use crate::timer::{get_time_us, NSEC_PER_SEC};
use crate::{
    config::CLOCK_FREQ,
    sync::UPIntrFreeCell,
    timer::{get_time, USEC_PER_SEC},
};

use super::{pid2process, Signum};

pub const UTIME_NOW: usize = (1 << 30) - 1;
pub const UTIME_OMIT: usize = (1 << 30) - 2;

#[derive(Copy, Clone, Debug)]
pub struct TimeVal {
    pub tv_sec: usize,
    pub tv_usec: usize,
}

#[derive(Copy, Clone, Debug)]
pub struct TimeSpec {
    pub tv_sec: usize,
    pub tv_nsec: usize,
}

#[derive(Copy, Clone, Debug)]
pub struct ITimerVal {
    pub it_interval: TimeVal,
    pub it_value: TimeVal,
}

impl TimeVal {
    pub fn new() -> Self {
        Self {
            tv_sec: 0,
            tv_usec: 0,
        }
    }

    pub fn is_zero(&self) -> bool {
        self.tv_sec == 0 && self.tv_usec == 0
    }

    pub fn to_usec(&self) -> usize {
        self.tv_sec * USEC_PER_SEC + self.tv_usec
    }
}

impl TimeSpec {
    pub fn new() -> Self {
        Self {
            tv_sec: 0,
            tv_nsec: 0,
        }
    }

    pub fn is_zero(&self) -> bool {
        self.tv_sec == 0 && self.tv_nsec == 0
    }

    pub fn to_nsec(&self) -> usize {
        self.tv_sec * NSEC_PER_SEC + self.tv_nsec
    }
}

impl ITimerVal {
    pub fn new() -> Self {
        Self {
            it_interval: TimeVal::new(),
            it_value: TimeVal::new(),
        }
    }

    pub fn is_zero(&self) -> bool {
        self.it_interval.is_zero() && self.it_value.is_zero()
    }

    pub fn as_bytes(&self) -> &[u8] {
        let size = core::mem::size_of::<Self>();
        unsafe { core::slice::from_raw_parts(self as *const _ as usize as *const u8, size) }
    }
}

lazy_static! {
    pub static ref ITIMER_MANAGER: UPIntrFreeCell<ITimerManager> =
        unsafe { UPIntrFreeCell::new(ITimerManager::new()) };
}

pub struct ITimerManager {
    itimer_list: Vec<(usize, usize)>, // (us, pid), 按照 us 升序排列
}

impl ITimerManager {
    pub fn new() -> Self {
        Self {
            itimer_list: Vec::new(),
        }
    }

    pub fn insert_itimer(&mut self, itimer: ITimerVal, pid: usize) {
        self.insert_inner(itimer.it_value, pid);
    }

    fn insert_inner(&mut self, time_val: TimeVal, pid: usize) {
        let us = time_val.to_usec() + get_time_us();
        // 按照 us 升序排列
        if let Some(idx) = self.itimer_list.iter().position(|iter| iter.0 > us) {
            self.itimer_list.insert(idx, (us, pid));
        } else {
            self.itimer_list.push((us, pid));
        }
    }

    pub fn remove_itimer(&mut self, pid: usize) {
        if let Some(idx) = self.itimer_list.iter().position(|iter| iter.1 == pid) {
            self.itimer_list.remove(idx);
        }
    }

    pub fn check_itimer(&mut self) {
        let us = get_time_us();
        while let Some(iter) = self.itimer_list.first() {
            // 到期的一定是最前面的
            // println!("[debug] us: {}, tar: {}", us, iter.0);
            if iter.0 > us {
                break;
            } else {
                let iter = self.itimer_list.remove(0);
                if let Some(process) = pid2process(iter.1) {
                    // Add SIGALRM.
                    // println!("[debug] Add SIGALRM to process");
                    // 向主线程发送signal
                    let process_inner = process.inner_exclusive_access();
                    let task = process_inner.tasks[0].as_ref().unwrap();
                    task.inner_exclusive_access().signals |= Signum::SIGALRM;
                    let it_interval = process.inner_exclusive_access().itimer.it_interval;
                    if !it_interval.is_zero() {
                        // it_interval 不为0，则重新计时
                        self.insert_inner(it_interval, iter.1);
                    }
                }
            }
        }
    }
}
