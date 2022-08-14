use alloc::{vec::Vec, collections::BTreeMap};
use core::fmt::{self, Debug, Formatter};

use lazy_static::*;
use spin::Mutex;

use crate::config::MEMORY_END;

use super::{PhysAddr, PhysPageNum};

pub struct FrameTracker {
    pub ppn: PhysPageNum,
}

impl FrameTracker {
    pub fn new(ppn: PhysPageNum) -> Self {
        // page cleaning
        let bytes_array = ppn.get_bytes_array();
        for i in bytes_array {
            *i = 0;
        }
        Self { ppn }
    }
}

impl Debug for FrameTracker {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        f.write_fmt(format_args!("FrameTracker:PPN={:#x}", self.ppn.0))
    }
}

impl Drop for FrameTracker {
    fn drop(&mut self) {
        frame_dealloc(self.ppn);
    }
}

trait FrameAllocator {
    fn new() -> Self;
    fn alloc(&mut self) -> Option<PhysPageNum>;
    fn dealloc(&mut self, ppn: PhysPageNum);
}

pub struct StackFrameAllocator {
    current: usize,
    end: usize,
    recycled: Vec<usize>,
    ref_count: BTreeMap<usize, u8>,
}

impl StackFrameAllocator {
    pub fn init(&mut self, l: PhysPageNum, r: PhysPageNum) {
        self.current = l.0;
        self.end = r.0;
        println!("last {} Physical Frames.", self.end - self.current);
    }
}

impl FrameAllocator for StackFrameAllocator {
    fn new() -> Self {
        Self {
            current: 0,
            end: 0,
            recycled: Vec::new(),
            ref_count: BTreeMap::new(),
        }
    }
    fn alloc(&mut self) -> Option<PhysPageNum> {
        if let Some(ppn) = self.recycled.pop() {
            self.ref_count.insert(ppn, 1);
            Some(ppn.into())
        } else if self.current == self.end {
            None
        } else {
            self.current += 1;
            self.ref_count.insert(self.current - 1, 1);
            Some((self.current - 1).into())
        }
    }
    fn dealloc(&mut self, ppn: PhysPageNum) {
        let ppn = ppn.0;
        let ref_times = self.ref_count.get_mut(&ppn).unwrap();
        *ref_times -= 1;
        if *ref_times == 0 {
            self.ref_count.remove(&ppn);
            // validity check
            if ppn >= self.current || self.recycled.iter().any(|&v| v == ppn) {
                panic!("Frame ppn={:#x} has not been allocated!", ppn);
            }
            // recycle
            self.recycled.push(ppn);
        }
    }
}

impl StackFrameAllocator {
    fn add_ref(&mut self, ppn: PhysPageNum) {
        *self.ref_count.get_mut(&ppn.0).unwrap() += 1;
    }
    fn get_ref(&self, ppn: PhysPageNum) -> usize {
        *self.ref_count.get(&ppn.0).unwrap() as usize
    }
    fn get_rest(&self) -> usize {
        self.end - self.current + self.recycled.len()
    }
}

type FrameAllocatorImpl = StackFrameAllocator;

lazy_static! {
    pub static ref FRAME_ALLOCATOR: Mutex<FrameAllocatorImpl> =
         Mutex::new(FrameAllocatorImpl::new());
}

pub fn init_frame_allocator() {
    extern "C" {
        fn ekernel();
    }
    FRAME_ALLOCATOR.lock().init(
        PhysAddr::from(ekernel as usize).ceil(),
        PhysAddr::from(MEMORY_END).floor(),
    );
}

pub fn frame_alloc() -> Option<FrameTracker> {
    FRAME_ALLOCATOR
        .lock()
        .alloc()
        .map(FrameTracker::new)
}

pub fn frame_add_ref(ppn: PhysPageNum) {
    FRAME_ALLOCATOR.lock().add_ref(ppn)
}

pub fn frame_get_ref(ppn: PhysPageNum) -> usize {
    FRAME_ALLOCATOR.lock().get_ref(ppn)
}

pub fn frame_dealloc(ppn: PhysPageNum) {
    FRAME_ALLOCATOR.lock().dealloc(ppn);
}

pub fn frame_get_rest() {
    println!("remain {} pages.", FRAME_ALLOCATOR.lock().get_rest());
}

#[allow(unused)]
pub fn frame_allocator_test() {
    let mut v: Vec<FrameTracker> = Vec::new();
    for i in 0..5 {
        let frame = frame_alloc().unwrap();
        println!("{:?}", frame);
        v.push(frame);
    }
    v.clear();
    for i in 0..5 {
        let frame = frame_alloc().unwrap();
        println!("{:?}", frame);
        v.push(frame);
    }
    drop(v);
    println!("frame_allocator_test passed!");
}

pub fn add_free(ppn: usize) {
    FRAME_ALLOCATOR.lock().recycled.push(ppn)
}
