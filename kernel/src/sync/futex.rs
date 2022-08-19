use alloc::{
    collections::{BTreeMap, VecDeque},
    sync::Arc,
    vec::Vec,
};
use lazy_static::lazy_static;

use crate::task::unblock_task;
use crate::{
    const_def,
    mm::translated_ref,
    task::{block_current_and_run_next, current_task, current_user_token, TaskControlBlock},
};

use super::UPIntrFreeCell;

const_def!(FUTEX_WAIT,              0);
const_def!(FUTEX_WAKE,              1);
const_def!(FUTEX_FD,                2);
const_def!(FUTEX_REQUEUE,		    3);
const_def!(FUTEX_CMP_REQUEUE,       4);
const_def!(FUTEX_WAKE_OP,           5);
const_def!(FUTEX_LOCK_PI,		    6);
const_def!(FUTEX_UNLOCK_PI,		    7);
const_def!(FUTEX_TRYLOCK_PI,   	    8);
const_def!(FUTEX_WAIT_BITSET,	    9);
const_def!(FUTEX_PRIVATE,           128);
const_def!(FUTEX_CLOCK_REALTIME,    256);
const_def!(FUTEX_OP_MASK,           !(FUTEX_PRIVATE | FUTEX_CLOCK_REALTIME));


lazy_static! {
    pub static ref FUTEX_MANAGER: UPIntrFreeCell<BTreeMap<usize, Futex>> =
        unsafe { UPIntrFreeCell::new(BTreeMap::new()) };
}

pub struct Futex {
    waiters: UPIntrFreeCell<usize>,
    chain: UPIntrFreeCell<VecDeque<Arc<TaskControlBlock>>>,
}

impl Futex {
    pub fn new() -> Self {
        Self {
            waiters: unsafe { UPIntrFreeCell::new(0) },
            chain: unsafe { UPIntrFreeCell::new(VecDeque::new()) },
        }
    }
    pub fn waiters(&self) -> usize {
        *self.waiters.exclusive_access()
    }
    pub fn waiters_inc(&self) {
        let mut waiters = self.waiters.exclusive_access();
        *waiters += 1;
    }
    pub fn waiters_dec(&self) {
        let mut waiters = self.waiters.exclusive_access();
        *waiters -= 1;
    }
}

/// 将当前线程阻塞在uaddr处
/// ! timeout未实现
pub fn futex_wait(uaddr: usize, val: usize, timeout: usize) -> isize {
    let uval = translated_ref(current_user_token(), uaddr as *const u32);
    // println!("[wait] uval: {:#X}, val: {:#X}", uval, val as u32);
    if *uval == val as u32 {
        let mut futex_manager = FUTEX_MANAGER.exclusive_access();
        let futex = if let Ok(futex) = futex_manager.try_insert(uaddr, Futex::new()) {
            futex
        } else {
            futex_manager.get(&uaddr).unwrap()
        };
        // let futex = if futex_manager.contains_key(&uaddr) {
        //     futex_manager.get(&uaddr).unwrap()
        // } else {
        //     futex_manager.insert(uaddr, Futex::new());
        //     futex_manager.get(&uaddr).unwrap()
        // };
        futex.waiters_inc();
        let mut futex_queue = futex.chain.exclusive_access();
        futex_queue.push_back(current_task().unwrap().clone());
        drop(futex_queue);
        drop(futex_manager);
        block_current_and_run_next();
        0
    } else {
        -1
    }
}

/// 唤醒uaddr处的num_wake个线程
/// 返回实际唤醒的线程数量
pub fn futex_wake(uaddr: usize, num_wake: usize) -> usize {
    let mut futex_manager = FUTEX_MANAGER.exclusive_access();
    if let Some(futex) = futex_manager.get(&uaddr) {
    // if let Some((_addr, futex)) = futex_manager.first_key_value() {
        // println!("[wake] find futex, waiters :{}", futex.waiters());
        let mut futex_queue = futex.chain.exclusive_access();
        let real_wake = num_wake.min(futex.waiters());
        let mut wake_queue = Vec::new();
        for _i in 0..real_wake {
            let task = futex_queue.pop_front().unwrap();
            wake_queue.push(task);
            futex.waiters_dec();
        }
        drop(futex_queue);
        if futex.waiters() == 0 {
            futex_manager.remove(&uaddr);
        }
        wake_queue.into_iter().for_each(|task| {
            // println!("[wake] tid: {}", task.gettid());
            unblock_task(task);
        });
        real_wake
    } else {
        0
    }
}

/// 先唤醒uaddr处num_wake个线程，再将剩余线程重新阻塞在uaddr2
/// 返回实际唤醒的线程数量
pub fn futex_requeue(uaddr: usize, num_wake: usize, uaddr2: usize) -> usize {
    let mut futex_manager = FUTEX_MANAGER.exclusive_access();
    if let Some(futex) = futex_manager.get(&uaddr) {
        let mut futex_queue = futex.chain.exclusive_access();
        let mut wake_queue = Vec::new();
        let mut requeue = Vec::new();
        // 被唤醒的线程
        let real_wake = num_wake.min(futex.waiters());
        for _i in 0..real_wake {
            let task = futex_queue.pop_front().unwrap();
            wake_queue.push(task);
            futex.waiters_dec();
        }
        // 被重新阻塞的线程
        let num_requeue = futex.waiters();
        for _i in 0..num_requeue {
            let task = futex_queue.pop_front().unwrap();
            requeue.push(task);
            futex.waiters_dec();
        }
        // 唤醒
        drop(futex_queue);
        if futex.waiters() == 0 {
            futex_manager.remove(&uaddr);
        }
        wake_queue.into_iter().for_each(|task| unblock_task(task));
        // 重新阻塞
        let futex2 = if let Ok(futex2) = futex_manager.try_insert(uaddr2, Futex::new()) {
            futex2
        } else {
            futex_manager.get(&uaddr2).unwrap()
        };
        let mut futex2_queue = futex2.chain.exclusive_access();
        requeue.into_iter().for_each(|task| {
            futex2_queue.push_back(task);
            futex2.waiters_inc();
        });

        real_wake
    } else {
        0
    }
}
