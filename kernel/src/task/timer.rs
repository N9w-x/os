use alloc::{collections::BTreeMap, vec::Vec};

use lazy_static::*;
use spin::Mutex;

use crate::config::CLOCK_FREQ;
use crate::timer::{get_time_us, NSEC_PER_SEC};
use crate::timer::get_time;
use crate::timer::USEC_PER_SEC;

use super::{Signum, tid2task};

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
    pub static ref ITIMER_MANAGER: Mutex<ITimerManager> =
         Mutex::new(ITimerManager::new()) ;
}

pub struct ITimerManager {
    itimer_list: Vec<(usize, usize)>, // (us, tid), 按照 us 升序排列
}

impl ITimerManager {
    pub fn new() -> Self {
        Self {
            itimer_list: Vec::new(),
        }
    }
    
    pub fn insert_itimer(&mut self, itimer: ITimerVal, tid: usize) {
        self.insert_inner(itimer.it_value, tid);
    }
    
    fn insert_inner(&mut self, time_val: TimeVal, tid: usize) {
        let us = time_val.to_usec() + get_time_us();
        // 按照 us 升序排列
        if let Some(idx) = self.itimer_list.iter().position(|iter| iter.0 > us) {
            self.itimer_list.insert(idx, (us, tid));
        } else {
            self.itimer_list.push((us, tid));
        }
    }
    
    pub fn remove_itimer(&mut self, tid: usize) {
        if let Some(idx) = self.itimer_list.iter().position(|iter| iter.1 == tid) {
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
                if let Some(task) = tid2task(iter.1) {
                    // Add SIGALRM.
                    // println!("[debug] Add SIGALRM to process");
                    // 向主线程发送signal
                    let mut task_inner = task.inner_exclusive_access();
                    task_inner.signals |= Signum::SIGALRM;
                    let it_interval = task_inner.itimer.it_interval;
                    if !it_interval.is_zero() {
                        // it_interval 不为0，则重新计时
                        self.insert_inner(it_interval, iter.1);
                    }
                }
            }
        }
    }
}
