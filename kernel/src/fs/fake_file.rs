use alloc::string::{String, ToString};

use crate::fs::{File, FileType};
use crate::mm::UserBuffer;

#[derive(Clone)]
pub struct FakeFile {
    pub is_write_fs: bool,
    pub path: String,
    pub file_type: FileType,
}

impl File for FakeFile {
    fn readable(&self) -> bool {
        true
    }
    
    fn writable(&self) -> bool {
        false
    }
    
    fn read(&self, buf: UserBuffer) -> usize {
        todo!()
    }
    
    fn write(&self, buf: UserBuffer) -> usize {
        todo!()
    }
}

impl FakeFile {
    pub fn new(path: &str, file_type: FileType) -> Self {
        Self {
            is_write_fs: false,
            path: path.to_string(),
            file_type,
        }
    }
}
