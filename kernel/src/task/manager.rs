use alloc::collections::{BTreeMap, VecDeque};
use alloc::sync::Arc;

use lazy_static::*;
use spin::Mutex;

use super::{ProcessControlBlock, task, TaskControlBlock};

pub struct TaskManager {
    ready_queue: VecDeque<Arc<TaskControlBlock>>,
}

/// A simple FIFO scheduler.
impl TaskManager {
    pub fn new() -> Self {
        Self {
            ready_queue: VecDeque::new(),
        }
    }
    pub fn add(&mut self, task: Arc<TaskControlBlock>) {
        self.ready_queue.push_back(task);
    }
    pub fn fetch(&mut self) -> Option<Arc<TaskControlBlock>> {
        self.ready_queue.pop_front()
    }
}

lazy_static! {
    pub static ref TASK_MANAGER: Mutex<TaskManager> =
        unsafe { Mutex::new(TaskManager::new()) };
    pub static ref PID2PCB: Mutex<BTreeMap<usize, Arc<ProcessControlBlock>>> =
        unsafe { Mutex::new(BTreeMap::new()) };
    pub static ref TID2TCB: Mutex<BTreeMap<usize, Arc<TaskControlBlock>>> =
        unsafe { Mutex::new(BTreeMap::new()) };
}

pub fn add_task(task: Arc<TaskControlBlock>) {
    TASK_MANAGER.lock().add(task);
}

pub fn fetch_task() -> Option<Arc<TaskControlBlock>> {
    TASK_MANAGER.lock().fetch()
}

pub fn pid2process(pid: usize) -> Option<Arc<ProcessControlBlock>> {
    let map = PID2PCB.lock();
    map.get(&pid).map(Arc::clone)
}

pub fn insert_into_pid2process(pid: usize, process: Arc<ProcessControlBlock>) {
    PID2PCB.lock().insert(pid, process);
}

pub fn remove_from_pid2process(pid: usize) {
    let mut map = PID2PCB.lock();
    if map.remove(&pid).is_none() {
        panic!("cannot find pid {} in pid2process!", pid);
    }
}

pub fn tid2task(tid: usize) -> Option<Arc<TaskControlBlock>> {
    let map = TID2TCB.lock();
    map.get(&tid).map(Arc::clone)
}

pub fn insert_into_tid2task(tid: usize, task: Arc<TaskControlBlock>) {
    TID2TCB.lock().insert(tid, task);
}

pub fn remove_from_tid2task(tid: usize) {
    let mut map = TID2TCB.lock();
    if map.remove(&tid).is_none() {
        panic!("cannot find tid {} in tid2process!", tid);
    }
}
