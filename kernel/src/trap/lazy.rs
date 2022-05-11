use crate::task::current_process;


pub fn lazy_check(addr: usize) -> bool {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();

    let heap_base = inner.heap_base.0;
    let heap_end = inner.heap_end.0;

    if heap_base <= addr && addr < heap_end {
        inner.memory_set.lazy_alloc_heap(addr.into());
        true
    } else {
        false
    }
}