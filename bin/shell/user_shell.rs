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
    cmds.push(String::from("busybox sh ./lua_testcode.sh"));
    // cmds.push(String::from("busybox sh ./lmbench_testcode.sh"));
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