use crate::{console::INFO, mm::VirtAddr, task::current_process};
use alloc::format;

pub fn lazy_check(addr: usize) -> bool {
    let va = VirtAddr::from(addr);
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    let fd_table = &inner.fd_table.clone();

    let heap_base = inner.memory_set.heap_base;
    let heap_end = inner.memory_set.heap_end;
    let mmap_base = inner.memory_set.mmap_area_base;
    let mmap_end = inner.memory_set.mmap_area_end;

    // println!(
    //     "{}",
    //     color!(
    //         format!(
    //             "addr: {:#x}, heap: {:#x} - {:#x}, mmap: {:#x} - {:#x}",
    //             addr, heap_base.0, heap_end.0, mmap_base.0, mmap_end.0
    //         ),
    //         INFO
    //     )
    // );

    if heap_base <= va && va < heap_end {
        inner.memory_set.lazy_alloc_heap(va)
    } else if mmap_base <= va && va < mmap_end {
        inner.memory_set.lazy_alloc_mmap_area(va, fd_table)
    } else {
        false
    }
}
