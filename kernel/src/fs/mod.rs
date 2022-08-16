use alloc::sync::Arc;
use alloc::vec::Vec;

use fat32::VFile;

pub use dev_fs::open_dev_file;
pub use file_descriptor::FileDescriptor;
pub use fs_info::*;
pub use inode::{ch_dir, FileType, init_rootfs, list_apps, open_file, OpenFlags, OSInode};
use inode::ROOT_INODE;
pub use io_vec::IOVec;
pub use path::WorkPath;
pub use pipe::{make_pipe, Pipe, PipeRingBuffer};
pub use stdio::{Stdin, Stdout};

use crate::fs::fs_tree::{insert_vfile, search_vfile};
use crate::mm::UserBuffer;

mod dev_fs;
mod file_descriptor;
mod fs_info;
mod fs_tree;
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
    fn read_blocked(&self) -> bool {
        false
    }
    fn write_blocked(&self) -> bool {
        false
    }
}

pub fn get_current_inode(curr_path: &str) -> Arc<VFile> {
    if curr_path == "/" || curr_path.starts_with('/') {
        ROOT_INODE.clone()
    } else {
        match search_vfile(curr_path) {
            Some(vfile) => vfile,
            None => {
                let path_vec: Vec<&str> = curr_path.split('/').collect();
                let vfile = ROOT_INODE.find_vfile_bypath(&path_vec).unwrap();
                insert_vfile(curr_path, vfile.clone());
                vfile
            }
        }
    }
}

pub fn search_inode(work_path: &str) {}
