use alloc::sync::{Arc, Weak};

use spin::Mutex;

use crate::mm::PhysPageNum;
use crate::trap::TrapContext;

use super::{KernelStack, kstack_alloc, ProcessControlBlock, Signum, TaskContext};
use super::id::TaskUserRes;

pub struct TaskControlBlock {
    // immutable
    pub process: Weak<ProcessControlBlock>,
    pub kstack: KernelStack,
    // mutable
    pub inner: Mutex<TaskControlBlockInner>,
}

impl TaskControlBlock {
    pub fn inner_exclusive_access(&self) -> spin::MutexGuard<'_, TaskControlBlockInner> {
        self.inner.lock()
    }
    
    pub fn get_user_token(&self) -> usize {
        let process = self.process.upgrade().unwrap();
        let inner = process.inner_exclusive_access();
        inner.memory_set.token()
    }
}

pub struct ClearChildTid {
    pub ctid: u32,
    pub addr: usize,
}

pub struct TaskControlBlockInner {
    pub res: Option<TaskUserRes>,
    pub trap_cx_ppn: PhysPageNum,
    pub task_cx: TaskContext,
    pub task_status: TaskStatus,
    pub exit_code: Option<i32>,
    pub clear_child_tid: Option<ClearChildTid>,
    /// 待响应信号
    pub signals: Signum,
    /// 正在响应的信号
    pub signal_handling: usize,
    /// 要屏蔽的信号（全局屏蔽）
    pub signal_masks: Signum,
    pub killed: bool,
    pub frozen: bool,
    /// 被打断的trap上下文
    pub trap_ctx_backup: Option<TrapContext>,
}

impl TaskControlBlockInner {
    pub fn get_trap_cx(&self) -> &'static mut TrapContext {
        self.trap_cx_ppn.get_mut()
    }
    
    #[allow(unused)]
    fn get_status(&self) -> TaskStatus {
        self.task_status
    }
    
    pub fn gettid(&self) -> usize {
        self.res.as_ref().unwrap().tid
    }
}

impl TaskControlBlock {
    pub fn new(
        process: Arc<ProcessControlBlock>,
        ustack_base: usize,
        alloc_user_res: bool,
    ) -> Self {
        let res = TaskUserRes::new(Arc::clone(&process), ustack_base, alloc_user_res);
        let trap_cx_ppn = res.trap_cx_ppn();
        let kstack = kstack_alloc();
        let kstack_top = kstack.get_top();
        Self {
            process: Arc::downgrade(&process),
            kstack,
            inner: unsafe {
                Mutex::new(TaskControlBlockInner {
                    res: Some(res),
                    trap_cx_ppn,
                    task_cx: TaskContext::goto_trap_return(kstack_top),
                    task_status: TaskStatus::Ready,
                    exit_code: None,
                    clear_child_tid: None,
                    signals: Signum::empty(),
                    signal_handling: 0,
                    signal_masks: Signum::empty(),
                    killed: false,
                    frozen: false,
                    trap_ctx_backup: None,
                })
            },
        }
    }
    
    pub fn gettid(&self) -> usize {
        self
            .inner_exclusive_access()
            .res
            .as_ref()
            .unwrap()
            .tid
    }
    
    pub fn get_task_id(&self) -> usize {
        self
            .inner_exclusive_access()
            .res
            .as_ref()
            .unwrap()
            .id
    }
}

#[derive(Copy, Clone, PartialEq)]
pub enum TaskStatus {
    Ready,
    Running,
    Blocking,
}
