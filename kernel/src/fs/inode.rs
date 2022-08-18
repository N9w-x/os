use alloc::string::String;
use alloc::sync::Arc;
use alloc::vec;
use alloc::vec::Vec;

use fat32::{FAT32Manager, VFile};
use fat32::{ATTRIBUTE_ARCHIVE, ATTRIBUTE_DIRECTORY, ATTRIBUTE_LFN, BLOCK_SZ};
use lazy_static::lazy_static;
use spin::Mutex;

use crate::drivers::BLOCK_DEVICE;
use crate::fs::{File, get_current_inode};
use crate::fs::fs_info::{Dirent, DTYPE_DIR, DTYPE_REG, DTYPE_UNKNOWN, Kstat, VFSFlag};
use crate::fs::fs_tree::{get_abs_path, insert_vfile, search_vfile};
use crate::mm::UserBuffer;
use crate::timer::get_time_us;

pub struct OSInode {
    readable: bool,
    writable: bool,
    inner: Mutex<OsInodeInner>,
}

pub struct OsInodeInner {
    offset: usize,
    atime: u64,
    mtime: u64,
    inode: Arc<VFile>,
}

impl OSInode {
    pub fn new(readable: bool, writable: bool, inode: Arc<VFile>) -> Self {
        Self {
            readable,
            writable,
            inner: Mutex::new(OsInodeInner {
                offset: 0,
                atime: 0,
                mtime: 0,
                inode,
            }),
        }
    }

    pub fn read_all(&self) -> Vec<u8> {
        let start = get_time_us();
        let mut inner = self.inner.lock();
        let mut buf = [0u8; BLOCK_SZ];
        //通过预分配内存空间减少拷贝次数
        let file_size = inner.inode.get_size();
        let mut vec = Vec::with_capacity(file_size as usize);

        loop {
            //分块读取文件内容
            let size = inner.inode.read_at(inner.offset, &mut buf);
            if size == 0 {
                break;
            }
            inner.offset += size;
            vec.extend_from_slice(&buf[..size]);
        }
        let end = get_time_us();
        println!("load file {:#} us", end - start);
        vec
    }

    pub fn read_all_with_out(&self) -> Vec<u8> {
        let mut inner = self.inner.lock();
        let mut buf = [0u8; BLOCK_SZ];
        //通过预分配内存空间减少拷贝次数
        let file_size = inner.inode.get_size();
        let mut vec = Vec::with_capacity(file_size as usize);
        let mut block_count = 0;

        loop {
            //分块读取文件内容
            let size = inner.inode.read_at(inner.offset, &mut buf);
            if size == 0 {
                break;
            }
            if block_count % 200 == 0 {
                println!("read 200 block!");
            }
            block_count += 1;
            inner.offset += size;
            vec.extend_from_slice(&buf[..size]);
        }

        vec
    }

    pub fn is_dir(&self) -> bool {
        let inner = self.inner.lock();
        inner.inode.is_dir()
    }

    pub fn clear(&self) {
        let inner = self.inner.lock();
        inner.inode.clear()
    }

    pub fn delete(&self) -> usize {
        self.inner.lock().inode.remove()
    }

    pub fn get_size(&self) -> usize {
        self.inner.lock().inode.get_size() as usize
    }

    pub fn get_name(&self) -> String {
        String::from(self.inner.lock().inode.get_name())
    }

    pub fn get_inode_id(&self) -> u32 {
        self.inner.lock().inode.first_cluster()
    }

    pub fn set_inode_id(&self, inode_id: u32) {
        self.inner.lock().inode.set_first_cluster(inode_id);
    }

    pub fn set_offset(&self, offset: usize) {
        self.inner.lock().offset = offset;
    }

    pub fn get_offset(&self) -> usize {
        self.inner.lock().offset
    }

    pub fn set_modification_time(&self, mtime: u64) {
        self.inner.lock().mtime = mtime;
    }

    pub fn modification_time(&self) -> u64 {
        self.inner.lock().mtime
    }

    pub fn set_accessed_time(&self, atime: u64) {
        self.inner.lock().atime = atime;
    }

    pub fn accessed_time(&self) -> u64 {
        self.inner.lock().atime
    }

    //在当前目录下创建文件
    pub fn create(&self, path: &str, _type: FileType) -> Option<Arc<OSInode>> {
        let inode = self.inner.lock().inode.clone();
        if !inode.is_dir() {
            println!("It's not a directory");
            return None;
        }
        let mut path_split: Vec<&str> = path.split('/').collect();
        let (readable, writable) = (true, true);
        if let Some(target_inode) = inode.find_vfile_bypath(&path_split) {
            target_inode.remove();
        }
        let filename = path_split.pop().unwrap();

        //创建失败的条件包括: 目录不存在,存在文件但不是目录
        match inode.find_vfile_bypath(&path_split) {
            None => None,
            Some(vfile) => {
                if !vfile.is_dir() {
                    None
                } else {
                    let attr = _type.into();
                    vfile
                        .create(filename, attr)
                        .map(|inode| Arc::new(OSInode::new(readable, writable, inode)))
                }
            }
        }
    }

    pub fn find(&self, path: &str, flags: OpenFlags) -> Option<Arc<OSInode>> {
        let inner = self.inner.lock();
        let path_split = path.split('/').collect();

        inner.inode.find_vfile_bypath(&path_split).map(|inode| {
            let (readable, writable) = flags.read_write();
            Arc::new(OSInode::new(readable, writable, inode.clone()))
        })
    }

    pub fn get_dirent(&self, dirent: &mut Dirent, offset: usize) -> isize {
        let mut inner = self.inner.lock();
        if let Some((mut name, offset, first_clu, attr)) =
            inner.inode.dirent_info(inner.offset + offset)
        {
            name.push('\0');
            let d_type = if attr & ATTRIBUTE_ARCHIVE != 0 {
                DTYPE_REG
            } else if attr & ATTRIBUTE_DIRECTORY != 0 {
                DTYPE_DIR
            } else {
                DTYPE_UNKNOWN
            };

            dirent.fill_info(
                &name,
                first_clu as u64,
                offset as i64,
                (offset as usize - inner.offset) as u16,
                d_type,
            );
            inner.offset = offset as usize;
            (name.len() + 8 * 4) as isize
        } else {
            -1
        }
    }

    pub fn dirent_info(&self, offset: usize) -> Option<(String, u32, u32, u8)> {
        self.inner.lock().inode.dirent_info(offset)
    }

    pub fn get_fstat(&self, fstat: &mut Kstat) {
        let vfile = self.inner.lock().inode.clone();
    
        let (size, access_t, modify_t, create_t, inode_num) = vfile.stat();
        let st_mode = {
            if self.get_name() == "null" {
                VFSFlag::S_IFCHR
            } else if vfile.is_dir() {
                VFSFlag::S_IFDIR | VFSFlag::S_IRWXU | VFSFlag::S_IRWXG | VFSFlag::S_IRWXO
            } else {
                VFSFlag::S_IFREG | VFSFlag::S_IRWXU | VFSFlag::S_IRWXG | VFSFlag::S_IRWXO
            }
        }
            .bits();
    
        fstat.update(
            self.get_inode_id() as u64,
            st_mode,
            self.get_size() as i64,
            self.accessed_time() as i64,
            self.modification_time() as i64,
            create_t,
        );
    }

    pub fn lseek(&self, offset: isize, whence: i32) -> isize {
        const SEEK_SET: i32 = 0;
        const SEEK_CUR: i32 = 1;
        const SEEK_END: i32 = 2;
        let mut inner = self.inner.lock();
        if whence == SEEK_CUR {
            if inner.offset as isize + offset < 0 {
                return -1;
            }
        } else if offset < 0 {
            return -1;
        }

        match whence {
            SEEK_SET => {
                inner.offset = offset as usize;
            }
            SEEK_CUR => {
                inner.offset += offset as usize;
            }
            SEEK_END => {
                let size = inner.inode.get_size();
                inner.offset = (size as usize + offset as usize);
            }
            _ => return -1,
        }

        inner.offset as isize
    }
}

impl File for OSInode {
    fn readable(&self) -> bool {
        self.readable
    }
    
    fn writable(&self) -> bool {
        self.writable
    }
    
    fn read(&self, mut buf: UserBuffer) -> usize {
        let mut inner = self.inner.lock();
        let mut read_size = 0;
        for slice in buf.buffers.iter_mut() {
            let size = inner.inode.read_at(inner.offset, *slice);
            if size == 0 {
                break;
            }
            inner.offset += size;
            read_size += size;
        }
        
        read_size
    }
    
    fn write(&self, buf: UserBuffer) -> usize {
        let mut inner = self.inner.lock();
        let mut write_size = 0;
        for buffer in buf.buffers.iter() {
            let size = inner.inode.write_at(inner.offset, *buffer);
            if size == 0 {
                break;
            }
            inner.offset += size;
            write_size += size;
        }
        write_size
    }
}

#[inline]
pub fn ch_dir(curr_path: &str, path: &str) -> isize {
    let curr_inode = get_current_inode(curr_path);
    let path_split: Vec<&str> = path.split("/").collect();
    match curr_inode.find_vfile_bypath(&path_split) {
        None => -1,
        Some(inode) => {
            let attribute = inode.get_attribute();
            if attribute == ATTRIBUTE_DIRECTORY || attribute == ATTRIBUTE_LFN {
                0
            } else {
                -1
            }
        }
    }
}

lazy_static! {
    pub static ref ROOT_INODE: Arc<VFile> = {
        let fat_manager = FAT32Manager::open(BLOCK_DEVICE.clone());
        Arc::new(fat_manager.get_root_vfile(&fat_manager))
    };
}

bitflags! {
    pub struct OpenFlags: u32 {
        const RDONLY = 0;
        const WRONLY = 1 << 0;
        const RDWR = 1 << 1;
        const _X2 = 1 << 2;
        const _X3 = 1 << 3;
        const _X4 = 1 << 4;
        const _X5 = 1 << 5;
        const CREATE = 1 << 6;
        const EXCL = 1 << 7;
        const _X8 = 1 << 8;
        const TRUNC = 1 << 9;
        const APPEND = 1 << 10;
        const NONBLOCK = 1 << 11;
        const _X12 = 1 << 12;
        const _X13 = 1 << 13;
        const _X14 = 1 << 14;
        const LARGEFILE = 1 << 15;
        const DIRECTORY_ = 1 << 16;
        const _X17 = 1 << 17;
        const _X18 = 1 << 18;
        const CLOEXEC = 1 << 19;
        const _X20 = 1 << 20;
        const DIRECTORY = 1 << 21;
    }
}

impl OpenFlags {
    //(readable,writable)
    pub fn read_write(&self) -> (bool, bool) {
        if self.is_empty() {
            (true, false)
        } else if self.contains(Self::WRONLY) {
            (false, true)
        } else {
            (true, true)
        }
    }
}

pub fn list_apps() {
    println!("/**** APPS ****");
    for app in ROOT_INODE.ls().unwrap() {
        println!("{}", app.0);
    }
    println!("**************/")
}

#[derive(Eq, PartialEq)]
pub enum FileType {
    Dir,
    Regular,
}

impl Into<u8> for FileType {
    fn into(self) -> u8 {
        match self {
            FileType::Dir => ATTRIBUTE_DIRECTORY,
            FileType::Regular => ATTRIBUTE_ARCHIVE,
        }
    }
}

/// path可以是基于当前工作路径的相对路径或者绝对路径
pub fn open_file(
    work_path: &str,
    path: &str,
    flags: OpenFlags,
    _type: FileType,
) -> Option<Arc<OSInode>> {
    let (readable, writable) = flags.read_write();
    let abs_path = get_abs_path(work_path, path);
    
    //if let Some(vfile) = search_vfile(&abs_path) {
    //    return Some(Arc::new(OSInode::new(readable, writable, vfile)));
    //}
    
    let cur_inode = get_current_inode(work_path);
    let mut path_split: Vec<&str> = path.split('/').collect();
    
    //创建文件
    if flags.contains(OpenFlags::CREATE) {
        //如果文件存在删除对应文件
        if let Some(inode) = cur_inode.find_vfile_bypath(&path_split) {
            if _type == FileType::Regular {
                inode.remove();
            }
        }
        
        let filename = path_split.pop().unwrap();
        let dir = cur_inode.find_vfile_bypath(&path_split).unwrap();
        let attr = _type.into();
        //创建文件
        dir.create(filename, attr).map(|inode| {
            insert_vfile(&abs_path, inode.clone());
            Arc::new(OSInode::new(readable, writable, inode))
        })
    } else {
        cur_inode.find_vfile_bypath(&path_split).map(|inode| {
            if flags.contains(OpenFlags::TRUNC) {
                inode.clear()
            }
            insert_vfile(&abs_path, inode.clone());
            Arc::new(OSInode::new(readable, writable, inode))
        })
    }
}

pub fn init_rootfs() {
    let _proc = open_file(
        "/",
        "proc",
        OpenFlags::CREATE | OpenFlags::DIRECTORY,
        FileType::Dir,
    )
        .unwrap();
    let _mounts = open_file(
        "/proc",
        "mounts",
        OpenFlags::CREATE | OpenFlags::DIRECTORY,
        FileType::Dir,
    )
        .unwrap();
    let _meminfo = open_file(
        "/proc",
        "meminfo",
        OpenFlags::CREATE | OpenFlags::DIRECTORY,
        FileType::Dir,
    )
        .unwrap();
    let _var = open_file(
        "/",
        "var",
        OpenFlags::CREATE | OpenFlags::DIRECTORY,
        FileType::Dir,
    )
        .unwrap();
    let _tmp = open_file(
        "/",
        "tmp",
        OpenFlags::CREATE | OpenFlags::DIRECTORY,
        FileType::Dir,
    )
        .unwrap();
    let _dev = open_file(
        "/",
        "dev",
        OpenFlags::CREATE | OpenFlags::DIRECTORY,
        FileType::Dir,
    )
        .unwrap();
    /*    let _null = open_file(
        "/dev",
        "null",
        OpenFlags::CREATE | OpenFlags::DIRECTORY,
        FileType::Dir,
    )
        .unwrap();*/
    /*    let zero = open_file(
        "/dev",
        "zero",
        OpenFlags::CREATE | OpenFlags::RDONLY,
        FileType::Regular,
    )
        .unwrap();*/
    let _invalid = open_file(
        "/dev/null",
        "invalid",
        OpenFlags::CREATE | OpenFlags::RDONLY,
        FileType::Regular,
    )
        .unwrap();
    /*    let _invalid = open_file(
        "/dev",
        "rtc",
        OpenFlags::CREATE | OpenFlags::RDONLY,
        FileType::Regular,
    )
        .unwrap();*/
    /*    let mut buf = vec![0u8; 1];
    let zero_write = UserBuffer::new(vec![unsafe {
        core::slice::from_raw_parts_mut(buf.as_mut_slice().as_mut_ptr(), 1)
    }]);
    zero.write(zero_write);*/
}
