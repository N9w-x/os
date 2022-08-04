use alloc::format;
use alloc::string::{String, ToString};
use alloc::sync::Arc;
use alloc::vec::Vec;
use core::iter::FromIterator;
use core::mem::size_of;

use fat32::DIRENT_SZ;
use k210_pac::spi0::ctrlr0::FRAME_FORMAT_A::QUAD;

use crate::console::INFO;
use crate::fs::{
    ch_dir, Dirent, File, FileDescriptor, FileType, get_current_inode, IOVec, Kstat, make_pipe,
    open_file, OpenFlags, OSInode, VFSFlag, WorkPath,
};
use crate::mm::{
    translated_byte_buffer, translated_ref, translated_refmut, translated_str, UserBuffer,
};
use crate::task::{current_process, current_task, current_user_token, TimeSpec, UTIME_NOW, UTIME_OMIT};
use crate::timer::{get_time_ns, NSEC_PER_SEC};

use super::errno::{EBADF, EMFILE, ENOENT, EPERM, ESPIPE};

const AT_FD_CWD: isize = -100;

pub fn sys_write(fd: usize, buf: *const u8, len: usize) -> isize {
    let token = current_user_token();
    let process = current_process();
    let inner = process.inner_exclusive_access();
    if fd >= inner.fd_table.len() {
        return -1;
    }
    if let Some(file) = &inner.fd_table[fd] {
        if !file.writable() {
            return -1;
        }
        let file = file.clone();
        // release current task TCB manually to avoid multi-borrow
        drop(inner);
        file.write(UserBuffer::new(translated_byte_buffer(token, buf, len))) as isize
    } else {
        -1
    }
}

pub fn sys_read(fd: usize, buf: *const u8, len: usize) -> isize {
    let token = current_user_token();
    let process = current_process();
    let inner = process.inner_exclusive_access();
    if fd >= inner.fd_table.len() {
        return -EPERM;
    }
    let fd_table = inner.fd_table.clone();
    drop(inner);
    if let Some(file) = &fd_table[fd] {
        if !file.readable() {
            return -EPERM;
        }
        // release current task TCB manually to avoid multi-borrow
        let ret = file.read(UserBuffer::new(translated_byte_buffer(token, buf, len))) as isize;
        //if fd > 2 {
        //    println!("[read] fd: {}, len: {}, ret: {}", fd, len, ret);
        //}
        ret
    } else {
        -1
    }
}

pub fn sys_open(fd: isize, path: *const u8, flags: u32) -> isize {
    let process = current_process();
    let token = current_user_token();
    let path = translated_str(token, path);
    // println!("{}", color!(format!("[open] path:{}", path), INFO));
    //rcore-tutorial和ultra os 你们可上点心吧
    let flags = unsafe { OpenFlags::from_bits_unchecked(flags) };
    //获取要打开文件的inode
    match if WorkPath::is_abs_path(&path) {
        open_file("/", &path, flags, FileType::Regular)
    } else if fd == AT_FD_CWD {
        let work_path = process.inner_exclusive_access().work_path.to_string();
        open_file(&work_path, &path, flags, FileType::Regular)
    } else {
        ////相对于fd的相对路径
        let inner = process.inner_exclusive_access();
        let fd_usize = fd as usize;
        if fd_usize >= inner.fd_table.len() {
            return -EPERM;
        }
        //todo rcore tutorial使用的锁和spin::mutex冲突了..
        let res = inner.fd_table[fd_usize].clone();
        drop(inner);
        match res {
            Some(FileDescriptor::Regular(os_inode)) => {
                if flags.contains(OpenFlags::CREATE) {
                    os_inode.create(&path, FileType::Regular)
                } else {
                    os_inode.find(&path, flags)
                }
            }
            _ => return -EPERM,
        }
    } {
        None => -ENOENT,
        Some(os_inode) => {
            //alloc fd and push into fd table
            let mut inner = process.inner_exclusive_access();
            let ret_fd = inner.alloc_fd();
            inner.fd_table[ret_fd] = Some(FileDescriptor::Regular(os_inode));
            assert!(inner.fd_table[ret_fd].is_some());
            ret_fd as isize
        }
    }
}

pub fn sys_close(fd: usize) -> isize {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    if fd >= inner.fd_table.len() || inner.fd_table[fd].is_none() {
        return -1;
    }
    inner.fd_table[fd].take();
    0
}

pub fn sys_pipe(pipe: *mut u32) -> isize {
    let process = current_process();
    let token = current_user_token();
    let mut inner = process.inner_exclusive_access();
    let (pipe_read, pipe_write) = make_pipe();
    let read_fd = inner.alloc_fd();
    inner.fd_table[read_fd] = Some(FileDescriptor::Abstract(pipe_read));
    let write_fd = inner.alloc_fd();
    inner.fd_table[write_fd] = Some(FileDescriptor::Abstract(pipe_write));
    *translated_refmut(token, pipe as *mut [u32; 2]) = [read_fd as u32, write_fd as u32];
    0
}

pub fn sys_dup(fd: usize) -> isize {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    if fd >= inner.fd_table.len() || inner.fd_table[fd].is_none() {
        return -EPERM;
    }
    if inner.fd_table.len() > inner.fd_max {
        return -EMFILE;
    }
    let new_fd = inner.alloc_fd();
    inner.fd_table[new_fd] = Some(inner.fd_table[fd].as_ref().unwrap().clone());
    new_fd as isize
}

pub fn sys_get_cwd(buf: *mut u8, len: usize) -> isize {
    let token = current_user_token();
    //进程控制块
    let pcb = current_process();
    
    let mut userbuf = UserBuffer::new(translated_byte_buffer(token, buf, len));
    let inner = pcb.inner_exclusive_access();
    let ret = userbuf.write(inner.work_path.to_string().as_bytes());
    if ret == 0 {
        0
    } else {
        buf as isize
    }
}

pub fn sys_chdir(path: *const u8) -> isize {
    let token = current_user_token();
    let pcb = current_process();
    let mut inner = pcb.inner_exclusive_access();
    let path = translated_str(token, path);
    
    //获取当前线程的work path
    let mut current_path = inner.work_path.to_string();
    drop(inner);
    //尝试切换目录
    let ret = ch_dir(&current_path, &path);
    //获取成功则更新工作目录
    if ret == 0 {
        let mut inner = pcb.inner_exclusive_access();
        inner.work_path.modify_path(&path);
    }
    ret
}

pub fn sys_mkdir(dir_fd: isize, path: *const u8, mode: u32) -> isize {
    let token = current_user_token();
    let pcb = current_process();
    let path = translated_str(token, path);
    
    match if WorkPath::is_abs_path(&path) {
        open_file("/", &path, OpenFlags::CREATE, FileType::Dir)
    } else if dir_fd == AT_FD_CWD {
        let work_path = pcb.inner_exclusive_access().work_path.to_string();
        open_file(&work_path, &path, OpenFlags::CREATE, FileType::Dir)
    } else {
        let mut inner = pcb.inner_exclusive_access();
        let fd_usize = dir_fd as usize;
        if fd_usize >= inner.fd_table.len() {
            return -1;
        }
        
        if let Some(FileDescriptor::Regular(os_inode)) = inner.fd_table[fd_usize].clone() {
            if !os_inode.is_dir() {
                return -1;
            }
            os_inode.create(&path, FileType::Regular)
        } else {
            return -1;
        }
    } {
        None => -1,
        Some(_) => 0,
    }
}

pub fn sys_dup3(old_fd: usize, new_fd: usize) -> isize {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    if old_fd >= inner.fd_table.len() || inner.fd_table[old_fd].is_none() {
        return -EPERM;
    }
    if old_fd > inner.fd_max {
        return -EMFILE;
    }
    // alloc a specific new_fd
    inner.alloc_specific_fd(new_fd);
    inner.fd_table[new_fd] = Some(inner.fd_table[old_fd].as_ref().unwrap().clone());
    new_fd as isize
}

//默认len 是 dirent_size的倍数
pub fn sys_getdents64(fd: isize, buf: *const u8, len: usize) -> isize {
    let token = current_user_token();
    let pcb = current_process();
    let mut user_buf = UserBuffer::new(translated_byte_buffer(token, buf, len));
    let dirent_size = core::mem::size_of::<Dirent>();
    let mut total_read = 0;
    
    //我为什么会喜欢这种写法(
    let dir_inode = if fd == AT_FD_CWD {
        let work_path = pcb.inner_exclusive_access().work_path.to_string();
        match open_file("/", &work_path, OpenFlags::RDONLY, FileType::Dir) {
            //当前目录下搜索不到文件
            None => return -1,
            Some(os_inode) => os_inode,
        }
    } else {
        let inner = pcb.inner_exclusive_access();
        let fd_usize = fd as usize;
        if fd_usize >= inner.fd_table.len() {
            return -1;
        }
        match &inner.fd_table[fd_usize] {
            Some(FileDescriptor::Regular(os_inode)) => os_inode.clone(),
            //文件未打开
            _ => return -1,
        }
    };
    
    let read_times = len / DIRENT_SZ;
    let mut dirent = Dirent::default();
    for _ in 0..read_times {
        if dir_inode.get_dirent(&mut dirent) > 0 {
            user_buf.write_at(total_read, dirent.as_bytes());
            total_read += dirent_size;
        }
    }
    
    if total_read == dir_inode.get_size() {
        0
    } else {
        dirent_size as isize
    }
}

//暂时不支持挂载(开摆
pub fn sys_mount(
    special: *const u8,
    dir: *const u8,
    fstype: *const u8,
    flags: usize,
    data: *const u8,
) -> isize {
    0
}

pub fn sys_umount(special: *const u8, flags: usize) -> isize {
    0
}

pub fn sys_fstat(fd: isize, kstat: *const u8) -> isize {
    let size = core::mem::size_of::<Kstat>();
    let token = current_user_token();
    let mut user_buf = UserBuffer::new(translated_byte_buffer(token, kstat, size));
    let pcb = current_process();
    let mut kstat = Kstat::default();
    let os_inode = if fd == AT_FD_CWD {
        let work_path = pcb.inner_exclusive_access().work_path.to_string();
        match open_file("/", &work_path, OpenFlags::RDONLY, FileType::Regular) {
            None => return -1,
            Some(os_inode) => os_inode,
        }
    } else {
        let fd_usize = fd as usize;
        let inner = pcb.inner_exclusive_access();
    
        if fd_usize >= inner.fd_table.len() {
            return -1;
        }
        match &inner.fd_table[fd_usize] {
            Some(FileDescriptor::Regular(os_inode)) => os_inode.clone(),
            _ => return -1,
        }
    };
    
    os_inode.get_fstat(&mut kstat);
    user_buf.write(kstat.as_bytes());
    0
}

pub fn sys_unlink(fd: isize, path: *const u8, flags: u32) -> isize {
    let token = current_user_token();
    let path = translated_str(token, path);
    let pcb = current_process();
    
    match if WorkPath::is_abs_path(&path) {
        open_file("/", &path, OpenFlags::RDWR, FileType::Regular)
    } else if fd == AT_FD_CWD {
        let work_path = pcb.inner_exclusive_access().work_path.to_string();
        open_file(&work_path, &path, OpenFlags::RDWR, FileType::Regular)
    } else {
        let fd_usize = fd as usize;
        let mut inner = pcb.inner_exclusive_access();
        
        if fd_usize >= inner.fd_table.len() {
            return -1;
        }
        
        match &inner.fd_table[fd_usize] {
            Some(FileDescriptor::Regular(os_inode)) => Some(os_inode.clone()),
            _ => return -1,
        }
    } {
        None => return -1,
        Some(os_inode) => {
            os_inode.delete();
        }
    }
    0
}

// todo 基本上所有的文件相关的系统调用都是一个样式,有时间的话之后抽象一下吧
// 假如真的有时间的话
pub fn sys_new_fstatat(fd: isize, path: *const u8, buf: *mut u8, flags: isize) -> isize {
    let token = current_user_token();
    let path = translated_str(token, path);
    let pcb = current_process();
    let mut user_buf = UserBuffer::new(translated_byte_buffer(
        token,
        buf,
        core::mem::size_of::<Kstat>(),
    ));
    
    // TODO 增加/dev/null文件
    if path == "/dev/null" {
        let mut kstat = Kstat {
            st_mode: (VFSFlag::S_IFCHR).bits(),
            ..Kstat::default()
        };
        user_buf.write(kstat.as_bytes());
        return 0;
    }
    
    return match if WorkPath::is_abs_path(&path) {
        open_file("/", &path, OpenFlags::RDONLY, FileType::Regular)
    } else if fd == AT_FD_CWD {
        let work_path = pcb.inner_exclusive_access().work_path.to_string();
        open_file(&work_path, &path, OpenFlags::RDONLY, FileType::Regular)
    } else {
        let inner = pcb.inner_exclusive_access();
        let fd_usize = fd as usize;
        if fd_usize >= inner.fd_table.len() {
            return -1;
        }
        
        return match &inner.fd_table[fd_usize] {
            Some(FileDescriptor::Regular(os_inode)) => {
                let mut kstat = Kstat::default();
                os_inode.get_fstat(&mut kstat);
                user_buf.write(kstat.as_bytes());
                0
            }
            _ => -1,
        };
    } {
        Some(os_inode) => {
            let mut kstat = Kstat::default();
            os_inode.get_fstat(&mut kstat);
            // TODO 不知道为什么有的文件的sec超级大
            kstat.st_atime_sec = 0;
            kstat.st_mtime_sec = 0;
            kstat.st_ctime_sec = 0;
            user_buf.write(kstat.as_bytes());
            0
        }
        None => -1,
    };
}

// pub fn sys_utimensat(dirfd: isize, path: *const u8, time: *const usize, flags: u32) -> isize {
//     // futimens等同于utimensat(fd, NULL, times, 0);

//     // 不使用当前工作路径，且没有提供新的路径
//     if path as usize == 0 && dirfd != AT_FD_CWD {
//         return -1;
//     }
//     let time = time as *const [TimeSpec; 2];

//     let process = current_process();
//     let mut inner = process.inner_exclusive_access();
//     let token = inner.get_user_token();
//     let path = translated_str(token, path);

//     let [last_access_time, last_modify_time] = translated_ref(token, time);

//     let work_path = inner.work_path.to_string();
//     let flags = OpenFlags::from_bits(flags).unwrap();

//     if let Some(file) = inner.open_file(dirfd, path, flags) {
//         let mut stat = Kstat::default();
//         file.get_fstat(&mut stat);
//         eprintln!("stat = {:?}", stat);
//         0
//     } else {
//         -1
//     }
// }

pub fn sys_ioctl(fd: usize, cmd: usize) -> isize {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    
    if fd as usize >= inner.fd_table.len() {
        return -1;
    }
    
    if let Some(descriptor) = &inner.fd_table[fd] {
        let file = descriptor.clone();
        drop(inner);
        file.ioctl(cmd)
    } else {
        -1
    }
}

// 因为这里不会有AT_FD_CWD这种情况,所以fd类型为usize
pub fn sys_writev(fd: usize, iov_ptr: usize, iov_cnt: usize) -> isize {
    let token = current_user_token();
    let pcb = current_process();
    let inner = pcb.inner_exclusive_access();
    
    if fd >= inner.fd_table.len() {
        return -EPERM;
    }
    
    let fd_table = inner.fd_table.clone();
    drop(inner);
    let mut write_size = 0;
    if let Some(file) = &fd_table[fd] {
        if !file.writable() {
            return -EPERM;
        }
        for i in 0..iov_cnt {
            let iov_ref = translated_ref(
                token,
                (iov_ptr + i * core::mem::size_of::<IOVec>()) as *const IOVec,
            );
            let buf = UserBuffer::new(unsafe {
                translated_byte_buffer(token, iov_ref.base, iov_ref.len)
            });
            write_size += file.write(buf);
        }
    } else {
        return -EPERM;
    }
    write_size as isize
}

pub fn sys_readv(fd: usize, iov_ptr: usize, iov_cnt: usize) -> isize {
    let token = current_user_token();
    let process = current_process();
    let inner = process.inner_exclusive_access();
    let fd_table = inner.fd_table.clone();
    drop(inner);
    let mut ret = 0isize;
    if let Some(file) = &fd_table[fd] {
        let f: Arc<dyn File + Send + Sync>;
        match file {
            FileDescriptor::Regular(os_inode) => f = os_inode.clone(),
            FileDescriptor::Abstract(os_inode) => f = os_inode.clone(),
        }
        if !f.readable() {
            return -EPERM;
        }
        for i in 0..iov_cnt {
            let iovec = translated_ref(token, (iov_ptr + i * core::mem::size_of::<IOVec>()) as *const IOVec);
            let buf = translated_byte_buffer(token, iovec.base, iovec.len);
            ret += f.read(UserBuffer::new(buf)) as isize;
        }
    } else {
        return -EPERM;
    }
    ret
}

pub fn sys_utimensat(
    dirfd: isize,
    ppath: *const u8,
    times: *const TimeSpec,
    _flags: isize,
) -> isize {
    let process = current_process();
    let token = current_user_token();
    let path = if ppath as usize != 0 {
        translated_str(token, ppath)
    } else {
        String::from(".")
    };
    let p = process.inner_exclusive_access().work_path.to_string();
    let mut base_path = p.as_str();
    
    if path.starts_with("/") {
        base_path = "/";
    } else if dirfd != AT_FD_CWD {
        let dirfd = dirfd as usize;
        if dirfd >= process.inner_exclusive_access().fd_table.len() {
            return -EBADF;
        }
        let fd_table = process.inner_exclusive_access().fd_table.clone();
        if let Some(FileDescriptor::Regular(osfile)) = fd_table[dirfd].clone() {
            if ppath as usize == 0 {
                do_utimensat(osfile, times, token);
                return 0;
            } else if let Some(f) = osfile.find(path.as_str(), OpenFlags::empty()) {
                do_utimensat(f, times, token);
                return 0;
            }
        }
        return -ENOENT;
    }
    if let Some(f) = open_file(base_path, path.as_str(), OpenFlags::empty(), FileType::Regular) {
        do_utimensat(f, times, token);
        return 0;
    }
    return -ENOENT;
}

fn do_utimensat(file: Arc<OSInode>, times: *const TimeSpec, token: usize) {
    let curtime = (get_time_ns() / NSEC_PER_SEC) as u64;
    if times as usize == 0 {
        file.set_accessed_time(curtime);
        file.set_modification_time(curtime);
    } else {
        let atime_ts = translated_ref(token, times);
        match atime_ts.tv_nsec {
            UTIME_NOW => file.set_accessed_time(curtime),
            UTIME_OMIT => (),
            _ => file.set_accessed_time(atime_ts.tv_sec as u64),
        };
        let mtime_ts = translated_ref(token, unsafe { times.add(1) });
        match mtime_ts.tv_nsec {
            UTIME_NOW => file.set_modification_time(curtime),
            UTIME_OMIT => (),
            _ => file.set_modification_time(mtime_ts.tv_sec as u64),
        };
    }
}

pub fn sys_pread64(fd: usize, buf: *mut u8, count: usize, offset: usize) -> isize {
    let token = current_user_token();
    let process = current_process();
    let fd_table = process.inner_exclusive_access().fd_table.clone();
    if let Some(Some(f)) = fd_table.get(fd) {
        match f {
            FileDescriptor::Regular(os_inode) => {
                let old_off = os_inode.get_offset();
                os_inode.set_offset(offset);
                let read_cnt = os_inode
                    .read(UserBuffer::new(translated_byte_buffer(token, buf, count))) as isize;
                os_inode.set_offset(old_off);
                read_cnt
            }
            FileDescriptor::Abstract(_) => -ESPIPE,
        }
    } else {
        -EBADF
    }
}

pub fn sys_fs(option: usize, fs_name: usize, buf: usize) -> isize {
    let token = current_user_token();
    match option {
        1 => {
            let fs_name = translated_str(token, fs_name as *const u8);
            1
        }
        2 => {
            let mut user_buf = UserBuffer::new(translated_byte_buffer(token, buf as *mut u8, 10));
            //fat32.len() + zero end
            let vec_buf = r#"FAT32\0"#.as_bytes().to_vec();
            user_buf.write(&vec_buf);
            0
        }
        3 => 1,
        _ => -1,
    }
}

pub fn sys_lseek(fd: isize, offset: isize, whence: i32) -> isize {
    let pcb = current_process();
    let inner = pcb.inner_exclusive_access();
    let fd_table = inner.fd_table.clone();
    drop(inner);
    match &fd_table[fd as usize] {
        Some(FileDescriptor::Regular(os_inode)) => os_inode.lseek(offset, whence),
        Some(FileDescriptor::Abstract(_)) => -ESPIPE,
        _ => -EBADF,
    }
}

pub fn sys_fcntl(fd: usize, cmd: u32, arg: usize) -> isize {
    const F_DUPFD: u32 = 0;
    const F_GETFD: u32 = 1;
    const F_SETFD: u32 = 2;
    const F_DUPFD_CLOEXEC: u32 = 1030;
    
    let pcb = current_process();
    let mut inner = pcb.inner_exclusive_access();
    
    if fd >= inner.fd_table.len() {
        return -1;
    }
    
    if let Some(fd_) = &mut inner.fd_table[fd] {
        match cmd {
            F_DUPFD_CLOEXEC | F_DUPFD => {
                let new_fd = inner.alloc_fd();
                inner.fd_table[new_fd] = inner.fd_table[fd].clone();
                new_fd as isize
            }
            F_GETFD | F_SETFD => 0,
            _ => 0,
        }
    } else {
        -1
    }
}

pub fn sys_statfs(_path: *const u8, buf: *const u8) -> isize {
    let token = current_user_token();
    let buf_vec = translated_byte_buffer(token, buf, size_of::<Statfs>());
    let mut userbuf = UserBuffer::new(buf_vec);
    let statfs = Statfs::new();
    userbuf.write(statfs.as_bytes());
    0
}

#[repr(C)]
pub struct Statfs {
    f_type: i64,
    // Type of filesystem
    f_bsize: i64,
    // Optimal transfer block size
    f_blocks: i64,
    // Total data blocks in filesystem
    f_bfree: i64,
    // Free blocks in filesystem
    f_bavail: i64,
    // Free blocks available to unprivileged user
    f_files: i64,
    // Total inodes in filesystem
    f_ffree: i64,
    // Free inodes in filesystem
    f_fsid: i64,
    // Filesystem ID
    f_name_len: i64,
    // Maximum length of filenames
    f_frsize: i64,
    // Fragment size
    f_flags: i64,
    // Mount flags of filesystem
    f_spare: [i64; 4],  // Padding bytes
}

impl Statfs {
    pub fn new() -> Self {
        Self {
            f_type: 0x4006,
            f_bsize: 512,
            f_blocks: 1048576,
            f_bfree: 1048576,
            f_bavail: 0,
            f_files: 131072,
            f_ffree: 131072,
            f_fsid: 0,
            f_name_len: 255,
            f_frsize: 0,
            f_flags: 0,
            f_spare: [0; 4],
        }
    }
    
    pub fn as_bytes(&self) -> &[u8] {
        let size = core::mem::size_of::<Self>();
        unsafe { core::slice::from_raw_parts(self as *const _ as usize as *mut u8, size) }
    }
}
