use core::slice::from_raw_parts;

pub const DTYPE_DIR: u8 = 4;
pub const DTYPE_REG: u8 = 4;
pub const DTYPE_UNKNOWN: u8 = 0;

#[repr(C)]
pub struct Dirent {
    d_ino: u64,
    offset: i64,
    dirent_len: u16,
    d_type: u8,
    d_name: [u8; 128],
}

impl Dirent {
    pub fn default() -> Self {
        Self {
            d_ino: 0,
            offset: 0,
            dirent_len: 0,
            d_type: 0,
            d_name: [0; 128],
        }
    }

    pub fn new(name: &str, inode_id: u64, offset: i64, dirent_len: u16, d_type: u8) -> Self {
        Self {
            d_ino: inode_id,
            offset,
            dirent_len,
            d_type,
            d_name: Dirent::str2bytes(name),
        }
    }
    
    pub fn fill_info(&mut self, name: &str, inode: u64, offset: i64, dirent_len: u16, d_type: u8) {
        *self = Self {
            d_ino: inode,
            offset,
            dirent_len,
            d_type,
            d_name: Self::str2bytes(name),
        };
    }
    
    fn str2bytes(str: &str) -> [u8; 128] {
        let bytes = str.as_bytes();
        let len = bytes.len();
        assert!(len <= 128);
        let mut buf = [0u8; 128];
        let copy_part = &mut buf[..len];
        copy_part.copy_from_slice(bytes);
        buf
    }
    
    pub fn as_bytes(&self) -> &[u8] {
        let size = core::mem::size_of::<Dirent>();
        unsafe { from_raw_parts(self as *const _ as *const u8, size) }
    }
}

#[repr(C)]
pub struct Kstat {
    st_dev: u64,
    /* ID of device containing file */
    st_ino: u64,
    /* Inode number */
    st_mode: u32,
    /* File type and mode */
    st_nlink: u32,
    /* Number of hard links */
    st_uid: u32,
    st_gid: u32,
    st_rdev: u64,
    st_size: u32,
    st_blksize: u32,
    __pad2: i32,
    st_blocks: u64,
    st_atime_sec: i64,
    st_atime_nsec: i64,
    st_mtime_sec: i64,
    st_mtime_nsec: i64,
    st_ctime_sec: i64,
    st_ctime_nsec: i64,
}

impl Default for Kstat {
    fn default() -> Self {
        Self {
            st_dev: 0,
            st_ino: 0,
            st_mode: 0,
            st_nlink: 0,
            st_uid: 0,
            st_gid: 0,
            st_rdev: 0,
            st_size: 0,
            st_blksize: 0,
            __pad2: 0,
            st_blocks: 0,
            st_atime_sec: 0,
            st_atime_nsec: 0,
            st_mtime_sec: 0,
            st_mtime_nsec: 0,
            st_ctime_sec: 0,
            st_ctime_nsec: 0,
        }
    }
}

impl Kstat {
    pub fn as_bytes(&self) -> &[u8] {
        let size = core::mem::size_of::<Self>();
        unsafe { core::slice::from_raw_parts(self as *const Self as *const u8, size) }
    }
}
