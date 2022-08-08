use core::slice::from_raw_parts;

use fat32::BLOCK_SZ;

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

bitflags! {
    pub struct VFSFlag:u32{
        //file type mask
        const S_IFMT    = 0o170_000; /*mask*/

        const S_IFSOCK  = 0o140_000; /*socket file*/
        const S_IFLNK   = 0o120_000; /*link file*/
        const S_IFREG   = 0o100_000; /*regular file*/
        const S_IFBLK   = 0o060_000; /*block device*/
        const S_IFDIR   = 0o040_000; /*directory*/
        const S_IFCHR   = 0o020_000; /*char device*/
        const S_IFIFO   = 0o010_000; /*fifo*/

        //file mode mask
        const S_ISUID   = 0o4000; /*set uid*/
        const S_ISGID   = 0o2000; /*set gid*/
        const S_ISVTX   = 0o1000; /*stick bit*/

        //use
        const S_IRWXU   = 0o0700; /*read write execute*/
        const S_IRUSR   = 0o0400; /*read*/
        const S_IWUSR   = 0o0200; /*write*/
        const S_IXUSR   = 0o0100; /*exec*/

        //group
        const S_IRWXG   = 00070; /**/
        const S_IRGRP   = 00040;
        const S_IWGRP   = 00020;
        const S_IXGRP   = 00010;

        const S_IRWXO   = 0o0007; //others (not in group) have read, write,and execute permission
        const S_IROTH   = 0o0004; //others have read permission
        const S_IWOTH   = 0o0002; //others have write permission
        const S_IXOTH   = 0o0001; //others have execute permission
        
    }
}

impl VFSFlag {
    pub fn create_flag(file_type: VFSFlag, user_perm: VFSFlag, group_perm: VFSFlag) -> Self {
        unsafe { VFSFlag::from_bits_unchecked((file_type | user_perm | group_perm).bits) }
    }
}

#[repr(C)]
#[derive(Debug)]
pub struct Kstat {
    pub st_dev: u64,
    /* Inode number */
    pub st_ino: u64,
    /* File type and mode */
    pub st_mode: u32,
    /* Number of hard links */
    pub st_nlink: u32,
    pub st_uid: u32,
    pub st_gid: u32,
    pub st_rdev: u64,
    pub __pad: u64,
    pub st_size: i64,
    pub st_blksize: u32,
    pub __pad2: u32,
    pub st_blocks: u64,
    pub st_atime_sec: i64,
    pub st_atime_nsec: i64,
    pub st_mtime_sec: i64,
    pub st_mtime_nsec: i64,
    pub st_ctime_sec: i64,
    pub st_ctime_nsec: i64,
}

impl Default for Kstat {
    fn default() -> Self {
        let flags = VFSFlag::create_flag(VFSFlag::S_IFREG, VFSFlag::S_IRWXU, VFSFlag::S_IRWXG);
        Self {
            st_dev: 0,
            st_ino: 0,
            st_mode: flags.bits,
            st_nlink: 1,
            st_uid: 0,
            st_gid: 0,
            st_rdev: 0,
            __pad: 0,
            st_size: 0,
            st_blksize: BLOCK_SZ as u32,
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
    pub fn update(
        &mut self,
        st_ino: u64,
        st_mode: u32,
        st_size: i64,
        access_time: i64,
        modify_time: i64,
        create_time: i64,
    ) {
        *self = Kstat {
            st_ino,
            st_mode,
            st_size,
            st_atime_sec: access_time,
            st_mtime_sec: modify_time,
            st_ctime_sec: create_time,
            ..*self
        }
    }
    
    pub fn as_bytes(&self) -> &[u8] {
        let size = core::mem::size_of::<Self>();
        unsafe { core::slice::from_raw_parts(self as *const Self as *const u8, size) }
    }
}

#[repr(C)]
pub struct PollFD {
    pub fd: i32,
    pub events: i16,
    pub revents: i16,
}

pub const POLLIN: i16 = 0x001;      /* There is data to read */
pub const POLLPRI: i16 = 0x002;     /* There is urgent data to read */
pub const POLLOUT: i16 = 0x004;     /* Writing now will not block */
pub const POLLERR: i16 = 0x008;     /* Error condition (output only) */
pub const POLLHUP: i16 = 0x010;     /* Hang up (output only) */
pub const POLLNVAL: i16 = 0x020;    /* Invalid request: fd not open (output only) */
pub const POLLRDNORM: i16 = 0x040;  /* Equivalent to POLLIN */
pub const POLLRDBAND: i16 = 0x080;  /* Priority band data can be read (generally unused on Linux) */
