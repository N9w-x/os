use alloc::sync::Arc;
use alloc::vec::Vec;

use fat32::VFile;

pub use file_descriptor::FileDescriptor;
pub use fs_info::*;
pub use inode::{ch_dir, FileType, init_rootfs, list_apps, open_file, OpenFlags, OSInode};
use inode::ROOT_INODE;
pub use io_vec::IOVec;
pub use path::WorkPath;
pub use pipe::{make_pipe, Pipe, PipeRingBuffer};
pub use stdio::{Stdin, Stdout};

use crate::mm::UserBuffer;

mod file_descriptor;
mod fs_info;
mod inode;
mod io_vec;
mod path;
mod pipe;
mod stdio;

pub trait File: Send + Sync {
    fn readable(&self) -> bool;
    fn writable(&self) -> bool;
    fn read(&self, buf: UserBuffer) -> usize;
    fn write(&self, buf: UserBuffer) -> usize;
    fn ioctl(&self, cmd: usize) -> isize {
        0
    }
}

pub fn get_current_inode(curr_path: &str) -> Arc<VFile> {
    if curr_path == "/" || curr_path.contains("^/") {
        ROOT_INODE.clone()
    } else {
        let path: Vec<&str> = curr_path.split("/").collect();
        ROOT_INODE.find_vfile_bypath(path).unwrap()
    }
}
