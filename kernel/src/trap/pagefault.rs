use crate::{
    console::INFO,
    mm::{VirtAddr, VirtPageNum},
    task::{current_process, current_task, ustack_top_from_id}, config::{USER_STACK_SIZE_MAX, USER_STACK_TOP},
};
use alloc::format;

pub fn page_fault_handler(addr: usize, is_store: bool) -> bool {
    let va = VirtAddr::from(addr);
    let process = current_process();
    let mut inner = process.inner_exclusive_access();

    if is_store {
        let vpn = VirtPageNum::from(va.floor());
        if let Some(pte) = inner.memory_set.translate(vpn) {
            if pte.is_cow() && pte.is_valid() {// CoW
                inner.memory_set.cow_alloc(vpn);
                return true;
            } else if pte.is_valid() {// 特判：已分配内存但发生StorePageFault，即向只读区域执行写操作
                return false;
            }
        }
    }
    drop(inner);
    drop(process);
    lazy_check(va)
}

// 检查 addr 所在页是否采取 lazy 策略。如果是，则分配内存，并返回true；否则返回false
pub fn lazy_check(va: VirtAddr) -> bool {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    let id = current_task().unwrap().get_task_id();
    let fd_table = &inner.fd_table.clone();

    let heap_base = inner.memory_set.heap_base;
    let heap_end = inner.memory_set.heap_end;
    let mmap_base = inner.memory_set.mmap_area_base;
    let mmap_end = inner.memory_set.mmap_area_end;
    let ustack_end = VirtAddr::from(ustack_top_from_id(USER_STACK_TOP, id));
    let ustack_base = VirtAddr::from(ustack_end.0 - USER_STACK_SIZE_MAX);

    // println!(
    //     "{}",
    //     color!(
    //         format!(
    //             "addr: {:#x}, heap: {:#x} - {:#x}, mmap: {:#x} - {:#x}, ustack: {:#X} - {:#X}",
    //             va.0, heap_base.0, heap_end.0, mmap_base.0, mmap_end.0, ustack_base.0, ustack_end.0
    //         ),
    //         INFO
    //     )
    // );

    if heap_base <= va && va < heap_end {
        inner.memory_set.lazy_alloc_heap(va)
    } else if mmap_base <= va && va < mmap_end {
        inner.memory_set.lazy_alloc_mmap_area(va, fd_table)
    } else if ustack_base <= va && va < ustack_end {
        inner.memory_set.lazy_alloc_map_area(va)
    } else {
        false
    }
}
