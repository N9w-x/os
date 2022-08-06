use crate::{console::INFO, mm::VirtAddr, task::current_process};
use alloc::format;

// 检查 addr 所在页是否采取 lazy 策略。如果是，则分配内存，并返回true；否则返回false
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

/// 检查 addr 所在页是否标记为CoW。如果是，则分配内存，返回true；否则返回false。
pub fn cow_check(addr: usize) -> bool {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    let vpn = VirtAddr::from(addr).floor();
    if let Some(pte) = inner.memory_set.translate(vpn) {
        if pte.is_cow() {
            inner.memory_set.cow_alloc(vpn);
            return true;
        }
    }
    false
}
