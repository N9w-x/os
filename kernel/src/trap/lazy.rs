use crate::{console::INFO, task::current_process};
use alloc::format;

pub fn lazy_check(addr: usize) -> bool {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    let fd_table = inner.fd_table.clone();

    let va = addr.into();
    let heap_base = inner.heap_base.0;
    let heap_end = inner.heap_end.0;
    let mmap_area_base = inner.mmap_area_base.0;
    let mmap_area_end = inner.mmap_area_end.0;

    // println!(
    //     "{}",
    //     color!(
    //         format!(
    //             "addr: {:#x}, heap: {:#x} - {:#x}, mmap: {:#x} - {:#x}",
    //             addr, heap_base, heap_end, mmap_area_base, mmap_area_end
    //         ),
    //         INFO
    //     )
    // );

    if heap_base <= addr && addr < heap_end {
        inner.memory_set.lazy_alloc_heap(va)
    } else if mmap_area_base <= addr && addr < mmap_area_end  {
        inner.memory_set.lazy_alloc_mmap_area(va, fd_table)
    } else {
        false
    }
}
