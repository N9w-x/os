#![no_std]
#![no_main]
#![allow(clippy::println_empty_string)]

extern crate alloc;

#[macro_use]
extern crate user_lib;

use alloc::string::String;
use alloc::vec::Vec;
use user_lib::*;

#[no_mangle]
pub fn main() -> i32 {
    final2_test();
    shutdown()
}

pub fn load_final2_test_cmds() -> Vec<String> {
    let mut cmds = Vec::new();
    cmds.push(String::from("busybox sh ./busybox_testcode.sh"));
    cmds.push(String::from("./test.sh date.lua"));
    cmds.push(String::from("./test.sh file_io.lua"));
    cmds.push(String::from("./test.sh max_min.lua"));
    cmds.push(String::from("./test.sh random.lua"));
    cmds.push(String::from("./test.sh remove.lua"));
    cmds.push(String::from("./test.sh round_num.lua"));
    cmds.push(String::from("./test.sh sin30.lua"));
    cmds.push(String::from("./test.sh sort.lua"));
    cmds.push(String::from("./test.sh strings.lua"));
    cmds.push(String::from("./test.sh strings.lua"));

    cmds.push(String::from("./busybox echo latency measurements"));
    cmds.push(String::from("./lmbench_all lat_syscall -P 1 null"));
    cmds.push(String::from("./lmbench_all lat_syscall -P 1 read"));
    cmds.push(String::from("./lmbench_all lat_syscall -P 1 write"));
    cmds.push(String::from("./busybox mkdir -p /var/tmp"));
    cmds.push(String::from("./busybox touch /var/tmp/lmbench"));
    cmds.push(String::from("./lmbench_all lat_syscall -P 1 stat /var/tmp/lmbench"));
    cmds.push(String::from("./lmbench_all lat_syscall -P 1 fstat /var/tmp/lmbench"));
    cmds.push(String::from("./lmbench_all lat_syscall -P 1 open /var/tmp/lmbench"));
    // cmds.push(String::from("./lmbench_all lat_select -n 100 -P 1 file"));
    cmds.push(String::from("./lmbench_all lat_sig -P 1 install"));
    cmds.push(String::from("./lmbench_all lat_sig -P 1 catch"));
    // cmds.push(String::from("./lmbench_all lat_sig -P 1 prot lat_sig"));
    // cmds.push(String::from("./lmbench_all lat_pipe -P 1"));
    // cmds.push(String::from("./lmbench_all lat_proc -P 1 fork"));
    // cmds.push(String::from("./lmbench_all lat_proc -P 1 exec"));
    // cmds.push(String::from("./busybox cp hello /tmp"));
    // cmds.push(String::from("./lmbench_all lat_proc -P 1 shell"));
    // cmds.push(String::from('./lmbench_all lmdd label="File /var/tmp/XXX write bandwidth:" of=/var/tmp/XXX move=1m fsync=1 cmds.push(String::from("print=3"'));
    // cmds.push(String::from("./lmbench_all lat_pagefault -P 1 /var/tmp/XXX"));
    // cmds.push(String::from("./lmbench_all lat_mmap -P 1 512k /var/tmp/XXX"));
    // cmds.push(String::from("./busybox echo file system latency"));
    // cmds.push(String::from("./lmbench_all lat_fs /var/tmp"));
    // cmds.push(String::from("./busybox echo Bandwidth measurements"));
    // cmds.push(String::from("./lmbench_all bw_pipe -P 1"));
    // cmds.push(String::from("./lmbench_all bw_file_rd -P 1 512k io_only /var/tmp/XXX"));
    // cmds.push(String::from("./lmbench_all bw_file_rd -P 1 512k open2close /var/tmp/XXX"));
    // cmds.push(String::from("./lmbench_all bw_mmap_rd -P 1 512k mmap_only /var/tmp/XXX"));
    // cmds.push(String::from("./lmbench_all bw_mmap_rd -P 1 512k open2close /var/tmp/XXX"));
    // cmds.push(String::from("./busybox echo context switch overhead"));
    // cmds.push(String::from("./lmbench_all lat_ctx -P 1 -s 32 2 4 8 16 24 32 64 96"));
    cmds
}

pub fn final2_test() {
    let cmds = load_final2_test_cmds();

    for cmd in cmds {
        let (args_copy, args_addr) = str2args(&cmd);
        let pid = fork();
        if pid == 0 {
            exec(args_copy[0].as_str(), args_addr.as_slice());
        } else {
            let mut exit_code = 0;
            waitpid(pid as usize, &mut exit_code);
        }
    }
}


pub fn str2args(s: &str) -> (Vec<String>, Vec<*const u8>) {
    let args_copy: Vec<String> = s
        .split(' ')
        .map(|s1| {
            let mut string = String::new();
            string.push_str(&s1);
            string.push('\0');
            string
        })
        .collect();

    let mut args_addr: Vec<*const u8> = args_copy.iter().map(|arg| arg.as_ptr()).collect();
    args_addr.push(core::ptr::null::<u8>());

    (args_copy, args_addr)
}