use alloc::sync::Arc;
use core::fmt::Debug;

use crate::fs_fat::{File, OSInode};
use crate::mm::UserBuffer;

#[derive(Clone)]
pub enum FileDescriptor {
    Regular(Arc<OSInode>),
    Abstract(Arc<dyn File + Send + Sync>),
}

impl File for FileDescriptor {
    fn readable(&self) -> bool {
        match self {
            FileDescriptor::Regular(inode) => inode.readable(),
            FileDescriptor::Abstract(inode) => inode.readable(),
        }
    }
    fn writable(&self) -> bool {
        match self {
            FileDescriptor::Regular(inode) => inode.writable(),
            FileDescriptor::Abstract(inode) => inode.writable(),
        }
    }
    fn read(&self, buf: UserBuffer) -> usize {
        match self {
            FileDescriptor::Regular(inode) => inode.read(buf),
            FileDescriptor::Abstract(inode) => inode.read(buf),
        }
    }
    fn write(&self, buf: UserBuffer) -> usize {
        match self {
            FileDescriptor::Regular(inode) => inode.write(buf),
            FileDescriptor::Abstract(inode) => inode.write(buf),
        }
    }
    fn ioctl(&self, cmd: usize) -> isize {
        match self {
            FileDescriptor::Regular(inode) => inode.ioctl(cmd),
            FileDescriptor::Abstract(inode) => inode.ioctl(cmd),
        }
    }
}

unsafe impl Sync for FileDescriptor {}

unsafe impl Send for FileDescriptor {}
