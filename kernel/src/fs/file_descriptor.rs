use alloc::sync::Arc;

use crate::fs::{File, OSInode};
use crate::fs::fake_file::FakeFile;
use crate::mm::UserBuffer;

use super::inode;

#[derive(Clone)]
pub enum FileDescriptor {
    Regular(Arc<OSInode>),
    Abstract(Arc<dyn File + Send + Sync>),
    Fake(Arc<FakeFile>),
}

impl File for FileDescriptor {
    fn readable(&self) -> bool {
        match self {
            FileDescriptor::Regular(inode) => inode.readable(),
            FileDescriptor::Abstract(inode) => inode.readable(),
            FileDescriptor::Fake(inode) => inode.readable(),
        }
    }
    fn writable(&self) -> bool {
        match self {
            FileDescriptor::Regular(inode) => inode.writable(),
            FileDescriptor::Abstract(inode) => inode.writable(),
            FileDescriptor::Fake(inode) => inode.writable(),
        }
    }
    fn read(&self, buf: UserBuffer) -> usize {
        match self {
            FileDescriptor::Regular(inode) => inode.read(buf),
            FileDescriptor::Abstract(inode) => inode.read(buf),
            FileDescriptor::Fake(inode) => inode.read(buf),
        }
    }
    fn write(&self, buf: UserBuffer) -> usize {
        match self {
            FileDescriptor::Regular(inode) => inode.write(buf),
            FileDescriptor::Abstract(inode) => inode.write(buf),
            FileDescriptor::Fake(inode) => inode.write(buf),
        }
    }
    fn ioctl(&self, cmd: usize) -> isize {
        match self {
            FileDescriptor::Regular(inode) => inode.ioctl(cmd),
            FileDescriptor::Abstract(inode) => inode.ioctl(cmd),
            FileDescriptor::Fake(inode) => inode.ioctl(cmd),
        }
    }
    fn read_blocked(&self) -> bool {
        match self {
            FileDescriptor::Regular(inode) => inode.read_blocked(),
            FileDescriptor::Abstract(inode) => inode.read_blocked(),
            FileDescriptor::Fake(inode) => inode.read_blocked(),
        }
    }
    fn write_blocked(&self) -> bool {
        match self {
            FileDescriptor::Regular(inode) => inode.write_blocked(),
            FileDescriptor::Abstract(inode) => inode.write_blocked(),
            FileDescriptor::Fake(inode) => inode.write_blocked(),
        }
    }
}

unsafe impl Sync for FileDescriptor {}

unsafe impl Send for FileDescriptor {}
