use alloc::string::{String, ToString};
use alloc::sync::Arc;
use alloc::vec::Vec;
use core::iter::FromIterator;

use simple_fat32::DIRENT_SZ;

use crate::fs_fat::{
    ch_dir, Dirent, downcast_to_inode, File, FileDescriptor, FileType, get_current_inode,
    make_pipe, open_file, OpenFlags, OSInode, WorkPath,
};
use crate::mm::{translated_byte_buffer, translated_refmut, translated_str, UserBuffer};
use crate::task::{current_process, current_task, current_user_token};

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
        return -1;
    }
    if let Some(file) = &inner.fd_table[fd] {
        let file = file.clone();
        if !file.readable() {
            return -1;
        }
        // release current task TCB manually to avoid multi-borrow
        drop(inner);
        file.read(UserBuffer::new(translated_byte_buffer(token, buf, len))) as isize
    } else {
        -1
    }
}

pub fn sys_open(fd: isize, path: *const u8, flags: u32) -> isize {
    let process = current_process();
    let token = current_user_token();
    let path = translated_str(token, path);
    //rcore-tutorial和ultra os 你们可上点心吧
    let flags = unsafe { OpenFlags::from_bits_unchecked(flags) };

    //获取要打开文件的inode
    match if WorkPath::is_abs_path(&path) {
        open_file("/", &path, flags, FileType::Normal)
    } else if fd == AT_FD_CWD {
        let work_path = process.inner_exclusive_access().work_path.to_string();
        open_file(&work_path, &path, flags, FileType::Normal)
    } else {
        //相对于fd的相对路径
        let mut inner = process.inner_exclusive_access();
        let fd_usize = fd as usize;
        if fd_usize >= inner.fd_table.len() {
            return -1;
        }

        match downcast_to_inode(&inner.fd_table[fd_usize]) {
            None => {
                //无法通过fd找到文件,直接返回
                return -1;
            }
            Some(inode) => {
                if flags.contains(OpenFlags::CREATE) {
                    inode.create(&path, FileType::Normal)
                } else {
                    inode.find(&path, flags)
                }
            }
        }
    } {
        None => -1,
        Some(os_inode) => {
            let mut inner = process.inner_exclusive_access();
            let ret_fd = inner.alloc_fd();
            inner.fd_table[ret_fd] = Some(FileDescriptor::Regular(os_inode));
            ret_fd as isize
        }
    }
}

pub fn sys_close(fd: usize) -> isize {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    if fd >= inner.fd_table.len() {
        return -1;
    }
    if inner.fd_table[fd].is_none() {
        return -1;
    }
    inner.fd_table[fd].take();
    0
}

pub fn sys_pipe(pipe: *mut usize) -> isize {
    let process = current_process();
    let token = current_user_token();
    let mut inner = process.inner_exclusive_access();
    let (pipe_read, pipe_write) = make_pipe();
    let read_fd = inner.alloc_fd();
    inner.fd_table[read_fd] = Some(FileDescriptor::Abstract(pipe_read));
    let write_fd = inner.alloc_fd();
    inner.fd_table[write_fd] = Some(FileDescriptor::Abstract(pipe_write));
    *translated_refmut(token, pipe) = read_fd;
    *translated_refmut(token, unsafe { pipe.add(1) }) = write_fd;
    0
}

pub fn sys_dup(fd: usize) -> isize {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    if fd >= inner.fd_table.len() || inner.fd_table[fd].is_none() {
        return -1;
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
    //fixme chdir中存在来源不明的加锁,不drop会导致系统panic
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

pub const AT_FD_CWD: isize = -100;

pub fn sys_mkdir(dir_fd: isize, path: *const u8, mode: u32) -> isize {
    let token = current_user_token();
    let pcb = current_process();
    let path = translated_str(token, path);

    // todo 修改fd,获取具体的os inode类型
    match if WorkPath::is_abs_path(&path) {
        open_file("/", &path, OpenFlags::CREATE, FileType::Dir)
    } else if dir_fd == AT_FD_CWD {
        let work_path = pcb.inner_exclusive_access().work_path.to_string();
        open_file(&work_path, &path, OpenFlags::CREATE, FileType::Dir)
    } else {
        todo!()
    } {
        None => -1,
        Some(_) => 0,
    }
}

pub fn sys_dup3(old_fd: usize, new_fd: usize) -> isize {
    let process = current_process();
    let mut inner = process.inner_exclusive_access();
    if old_fd >= inner.fd_table.len()
        || inner.fd_table[old_fd].is_none()
        || old_fd == new_fd
        || new_fd >= 128
    {
        // TODO: 128 is FD_MAX
        return -1;
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
