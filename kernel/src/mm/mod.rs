pub use address::{align_up, PhysAddr, PhysPageNum, StepByOne, VirtAddr, VirtPageNum, VPNRange};
pub use aux::AuxHeader;
pub use frame_allocator::{add_free, frame_alloc, frame_dealloc, FrameTracker};
pub use heap_allocator::get_rest;
pub use memory_set::{KERNEL_SPACE, kernel_token, MapPermission, MemorySet};
pub use memory_set::remap_test;
pub use mmap::MemoryMapArea;
pub use page_table::{
    PageTable, PageTableEntry, PTEFlags, translated_byte_buffer, translated_ref, translated_refmut,
    translated_str, UserBuffer, UserBufferIterator,
};

mod address;
mod aux;
mod frame_allocator;
mod heap_allocator;
mod memory_set;
mod mmap;
mod page_table;

pub fn init() {
    heap_allocator::init_heap();
    frame_allocator::init_frame_allocator();
    KERNEL_SPACE.lock().activate();
}
//
//pub fn init_other() {
//    // KERNEL_SPACE.lock().activate_other();
//    unsafe {
//        satp::write(memory_set::SATP);
//        asm!("sfence.vma");
//    }
//}
