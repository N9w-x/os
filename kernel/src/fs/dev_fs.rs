use alloc::sync::Arc;

use crate::fs::File;
use crate::mm::UserBuffer;

#[derive(Default)]
pub struct Zero;

#[derive(Default)]
pub struct Null;

impl File for Zero {
    fn readable(&self) -> bool {
        true
    }
    
    fn writable(&self) -> bool {
        true
    }
    
    fn read(&self, mut buf: UserBuffer) -> usize {
        buf.clear()
    }
    
    fn write(&self, buf: UserBuffer) -> usize {
        buf.len()
    }
}

impl File for Null {
    fn readable(&self) -> bool {
        true
    }
    
    fn writable(&self) -> bool {
        true
    }
    
    fn read(&self, buf: UserBuffer) -> usize {
        0
    }
    
    fn write(&self, buf: UserBuffer) -> usize {
        buf.len()
    }
}

pub fn open_dev_file(path: &str) -> Option<Arc<dyn File + Send + Sync>> {
    if path.ends_with("zero") {
        Some(Arc::new(Zero::default()))
    } else if path.ends_with("null") {
        Some(Arc::new(Null::default()))
    } else {
        None
    }
}
