use alloc::{
    sync::{Arc, Weak},
    vec::Vec,
};

use lazy_static::*;
use spin::Mutex;

use crate::{config::{KERNEL_STACK_SIZE, PAGE_SIZE, TRAMPOLINE, TRAP_CONTEXT_BASE, USER_STACK_SIZE, USER_STACK_SIZE_MAX}, mm::VirtPageNum};
use crate::mm::{KERNEL_SPACE, MapPermission, PhysPageNum, VirtAddr};

use super::ProcessControlBlock;

pub struct RecycleAllocator {
    current: usize,
    recycled: Vec<usize>,
}

impl RecycleAllocator {
    pub fn new() -> Self {
        RecycleAllocator {
            current: 0,
            recycled: Vec::new(),
        }
    }
    pub fn alloc(&mut self) -> usize {
        if let Some(id) = self.recycled.pop() {
            id
        } else {
            self.current += 1;
            self.current - 1
        }
    }
    pub fn dealloc(&mut self, id: usize) {
        assert!(id < self.current);
        assert!(
            !self.recycled.iter().any(|i| *i == id),
            "id {} has been deallocated!",
            id
        );
        self.recycled.push(id);
    }
}

lazy_static! {
    static ref PID_ALLOCATOR: Mutex<RecycleAllocator> =
         Mutex::new(RecycleAllocator::new()) ;
    static ref TID_ALLOCATOR: Mutex<RecycleAllocator> =
         Mutex::new(RecycleAllocator::new()) ;
    static ref KSTACK_ALLOCATOR: Mutex<RecycleAllocator> =
         Mutex::new(RecycleAllocator::new()) ;
}

pub struct PidHandle(pub usize);

pub fn pid_alloc() -> PidHandle {
    PidHandle(PID_ALLOCATOR.lock().alloc())
}

impl Drop for PidHandle {
    fn drop(&mut self) {
        PID_ALLOCATOR.lock().dealloc(self.0);
    }
}

pub struct TidHandle(pub usize);

pub fn tid_alloc() -> usize {
    TID_ALLOCATOR.lock().alloc()
}

/// Return (bottom, top) of a kernel stack in kernel space.
pub fn kernel_stack_position(kstack_id: usize) -> (usize, usize) {
    let top = TRAMPOLINE - kstack_id * (KERNEL_STACK_SIZE + PAGE_SIZE);
    let bottom = top - KERNEL_STACK_SIZE;
    (bottom, top)
}

pub struct KernelStack(pub usize);

pub fn kstack_alloc() -> KernelStack {
    let kstack_id = KSTACK_ALLOCATOR.lock().alloc();
    let (kstack_bottom, kstack_top) = kernel_stack_position(kstack_id);
    KERNEL_SPACE.lock().insert_framed_area(
        kstack_bottom.into(),
        kstack_top.into(),
        MapPermission::R | MapPermission::W,
    );
    KernelStack(kstack_id)
}

impl Drop for KernelStack {
    fn drop(&mut self) {
        let (kernel_stack_bottom, _) = kernel_stack_position(self.0);
        let kernel_stack_bottom_va: VirtAddr = kernel_stack_bottom.into();
        KERNEL_SPACE
            .lock()
            .remove_area_with_start_vpn(kernel_stack_bottom_va.into());
    }
}

impl KernelStack {
    #[allow(unused)]
    pub fn push_on_top<T>(&self, value: T) -> *mut T
        where
            T: Sized,
    {
        let kernel_stack_top = self.get_top();
        let ptr_mut = (kernel_stack_top - core::mem::size_of::<T>()) as *mut T;
        unsafe {
            *ptr_mut = value;
        }
        ptr_mut
    }
    pub fn get_top(&self) -> usize {
        let (_, kernel_stack_top) = kernel_stack_position(self.0);
        kernel_stack_top
    }
}

pub struct TaskUserRes {
    pub tid: usize,
    // 线程标识符
    pub id: usize,
    // 进程内线程编号：0, 1, 2...
    pub ustack_top: usize,
    pub process: Weak<ProcessControlBlock>,
}

fn trap_cx_bottom_from_id(id: usize) -> usize {
    TRAP_CONTEXT_BASE - id * PAGE_SIZE
}

pub fn ustack_top_from_id(ustack_top: usize, id: usize) -> usize {
    ustack_top - id * (PAGE_SIZE + USER_STACK_SIZE_MAX)
}

impl TaskUserRes {
    pub fn new(
        process: Arc<ProcessControlBlock>,
        ustack_top: usize,
        alloc_user_res: bool,
    ) -> Self {
        let tid = tid_alloc();
        let id = process.inner_exclusive_access().alloc_id();
        let task_user_res = Self {
            tid,
            id,
            ustack_top,
            process: Arc::downgrade(&process),
        };
        if alloc_user_res {
            task_user_res.alloc_user_res();
        }
        task_user_res
    }
    
    pub fn alloc_user_res(&self) {
        let process = self.process.upgrade().unwrap();
        let mut process_inner = process.inner_exclusive_access();
        // alloc user stack
        let ustack_top = ustack_top_from_id(self.ustack_top, self.id);
        let ustack_bottom = ustack_top - USER_STACK_SIZE;
        process_inner.memory_set.insert_framed_area(
            ustack_bottom.into(),
            ustack_top.into(),
            MapPermission::R | MapPermission::W | MapPermission::U,
        );
        // alloc trap_cx
        let trap_cx_bottom = trap_cx_bottom_from_id(self.id);
        let trap_cx_top = trap_cx_bottom + PAGE_SIZE;
        process_inner.memory_set.insert_framed_area(
            trap_cx_bottom.into(),
            trap_cx_top.into(),
            MapPermission::R | MapPermission::W,
        );
    }
    
    fn dealloc_user_res(&self) {
        // dealloc tid
        let process = self.process.upgrade().unwrap();
        let mut process_inner = process.inner_exclusive_access();
        // dealloc ustack manually
        let ustack_top_va = ustack_top_from_id(self.ustack_top, self.id);
        let mut va = ustack_top_va - USER_STACK_SIZE_MAX;
        loop {
            if va >= ustack_top_va {
                break;
            }
            // lazy导致ustack可能由多个MapArea组成，因此需要依次释放
            process_inner
                .memory_set
                .remove_area_with_start_vpn(VirtPageNum::from(VirtAddr::from(va)));
            va += PAGE_SIZE;
        }
        // dealloc trap_cx manually
        let trap_cx_bottom_va: VirtAddr = trap_cx_bottom_from_id(self.id).into();
        process_inner
            .memory_set
            .remove_area_with_start_vpn(trap_cx_bottom_va.into());
    }
    
    #[allow(unused)]
    pub fn alloc_id(&mut self) {
        self.id = self
            .process
            .upgrade()
            .unwrap()
            .inner_exclusive_access()
            .alloc_id();
    }
    
    pub fn dealloc_id(&self) {
        let process = self.process.upgrade().unwrap();
        let mut process_inner = process.inner_exclusive_access();
        process_inner.dealloc_id(self.id);
    }
    
    pub fn trap_cx_user_va(&self) -> usize {
        trap_cx_bottom_from_id(self.id)
    }
    
    pub fn trap_cx_ppn(&self) -> PhysPageNum {
        let process = self.process.upgrade().unwrap();
        let process_inner = process.inner_exclusive_access();
        let trap_cx_bottom_va: VirtAddr = trap_cx_bottom_from_id(self.id).into();
        process_inner
            .memory_set
            .translate(trap_cx_bottom_va.into())
            .unwrap()
            .ppn()
    }
    
    pub fn ustack_top(&self) -> usize {
        self.ustack_top
    }
    pub fn ustack_base(&self) -> usize {
        // ustack_top_from_id(self.ustack_top, self.id) + USER_STACK_SIZE
        // TODO delete it maybe
        todo!();
        0
    }
}

impl Drop for TaskUserRes {
    fn drop(&mut self) {
        self.dealloc_id();
        self.dealloc_user_res();
    }
}
