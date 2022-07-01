use alloc::string::String;
use alloc::sync::Arc;
use alloc::vec::Vec;
use core::any::Any;

use fat32::VFile;

pub use file_descriptor::FileDescriptor;
pub use fs_info::{Dirent, Kstat};
pub use inode::{ch_dir, list_apps, open_file};
pub use inode::{FileType, OpenFlags, OSInode};
pub use io_vec::IOVec;
pub use path::WorkPath;
pub use pipe::{make_pipe, Pipe};
pub use stdio::{Stdin, Stdout};

use crate::fs_fat::inode::ROOT_INODE;
use crate::mm::UserBuffer;

mod file_descriptor;
mod fs_info;
mod inode;
mod io_vec;
mod mount;
mod path;
mod pipe;
mod stdio;

pub trait File: Send + Sync {
    fn readable(&self) -> bool;
    fn writable(&self) -> bool;
    fn read(&self, buf: UserBuffer) -> usize;
    fn write(&self, buf: UserBuffer) -> usize;
}

pub fn get_current_inode(curr_path: &str) -> Arc<VFile> {
    if curr_path == "/" || curr_path.contains("^/") {
        ROOT_INODE.clone()
    } else {
        let path: Vec<&str> = curr_path.split("/").collect();
        ROOT_INODE.find_vfile_bypath(path).unwrap()
    }
}
