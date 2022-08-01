use crate::mm::{
    translated_byte_buffer, UserBuffer,
};
use crate::sync::UPIntrFreeCell;
use crate::task::{current_user_token};
use crate::fs_fat::PipeRingBuffer;
use alloc::sync::Arc;
use lazy_static::*;

lazy_static! {
    pub static ref SOCKET_BUF: Arc<UPIntrFreeCell<PipeRingBuffer>> = 
        Arc::new(unsafe { UPIntrFreeCell::new(PipeRingBuffer::new()) });
}

pub fn sys_sendto(sockfd: isize, buf: *const u8, len: usize , flags: isize , dest_addr: usize, addrlen: usize) -> isize {
    let token = current_user_token();
    let userbuf = UserBuffer::new(translated_byte_buffer(token, buf, len));
    let mut buf_iter = userbuf.into_iter();
    let mut write_size = 0isize;

    let mut ring_buffer = SOCKET_BUF.exclusive_access();
    let loop_write = ring_buffer.available_write();
    if loop_write == 0 {
        return -1;
    }
    // write at most loop_write bytes
    for _ in 0..loop_write {
        if let Some(byte_ref) = buf_iter.next() {
            ring_buffer.write_byte(unsafe { *byte_ref });
            write_size += 1;
        } else {
            return write_size;
        }
    }

    // println!(
    //     "sys_sendto(sockfd: {:#x?}, buf = ..., len:{}, flags={}, dest_addr={}, addrlen={} = 1 ---- fake",
    //     sockfd,
    //     len,
    //     flags,
    //     dest_addr,
    //     addrlen
    // );
    write_size
}

pub fn sys_recvfrom(_sockfd: isize, buf: *const u8, len: usize , _flags: isize , _src_addr: usize, _addrlen: usize) -> isize{
    let token = current_user_token();
    let userbuf = UserBuffer::new(translated_byte_buffer(token, buf, len));
    let mut buf_iter = userbuf.into_iter();
    let mut read_size = 0isize;

    let mut ring_buffer = SOCKET_BUF.exclusive_access();
    let loop_read = ring_buffer.available_read();
    if loop_read == 0 {
        return -1;
    }
    // read at most loop_read bytes
    for _ in 0..loop_read {
        if let Some(byte_ref) = buf_iter.next() {
            unsafe {
                *byte_ref = ring_buffer.read_byte();
            }
            read_size += 1;
        } else {
            return read_size;
        }
    }
    read_size
}