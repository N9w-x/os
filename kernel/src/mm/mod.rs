pub use address::{align_up, PhysAddr, PhysPageNum, StepByOne, VirtAddr, VirtPageNum};
use address::VPNRange;
pub use frame_allocator::{add_free, frame_alloc, frame_dealloc, FrameTracker};
pub use heap_allocator::get_rest;
pub use memory_set::{AuxHeader, KERNEL_SPACE, MapPermission, MemoryMapArea, MemorySet};
pub use memory_set::{kernel_token, remap_test};
pub use page_table::{
    PageTable, PageTableEntry, translated_byte_buffer, translated_ref, translated_refmut,
    translated_str, UserBuffer, UserBufferIterator,
};
use page_table::PTEFlags;

mod address;
mod frame_allocator;
mod heap_allocator;
mod memory_set;
mod page_table;

pub fn init() {
    heap_allocator::init_heap();
    frame_allocator::init_frame_allocator();
    KERNEL_SPACE.exclusive_access().activate();
}
