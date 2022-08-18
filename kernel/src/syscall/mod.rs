use alloc::format;
use core::ops::Not;

use errno::*;
use fs::*;
use net::*;
use process::*;
use sync::*;
use thread::*;
use utils::*;

use crate::console::{ERROR, INFO};
use crate::const_def;
use crate::sbi::shutdown;
use crate::task::{current_process, TimeSpec};

const SYSCALL_LINK_AT: usize = 37;
const SYSCALL_UNLINK_AT: usize = 35;
const SYSCALL_CLONE: usize = 220;
const SYSCALL_EXEC: usize = 221;
const SYSCALL_MUNMAP: usize = 215;
const SYSCALL_MMAP: usize = 222;
const SYSCALL_SLEEP: usize = 101;
const SYSCALL_UMOUNT2: usize = 39;
const SYSCALL_MOUNT: usize = 40;
const SYSCALL_FSTAT: usize = 80;
const SYSCALL_UTIMENSAT: usize = 88;
const SYSCALL_GET_DENTS64: usize = 61;
const SYSCALL_TIMES: usize = 153;
const SYSCALL_UNAME: usize = 160;
const SYSCALL_MKDIR_AT: usize = 34;
const SYSCALL_GETCWD: usize = 17;
const SYSCALL_CHDIR: usize = 49;
const SYSCALL_DUP: usize = 23;
const SYSCALL_IOCTL: usize = 29;

const SYSCALL_DUP3: usize = 24;
const SYSCALL_OPEN: usize = 56;
const SYSCALL_CLOSE: usize = 57;
const SYSCALL_PIPE: usize = 59;
const SYSCALL_READ: usize = 63;
const SYSCALL_WRITE: usize = 64;
const SYSCALL_EXIT: usize = 93;

const SYSCALL_YIELD: usize = 124;
const SYSCALL_KILL: usize = 129;
const SYSCALL_GET_TIME_OF_DAY: usize = 169;
const SYSCALL_GETPID: usize = 172;
const SYSCALL_GET_PPID: usize = 173;

const SYSCALL_BRK: usize = 214;

const SYSCALL_WAITPID: usize = 260;
const SYSCALL_THREAD_CREATE: usize = 1000;
const SYSCALL_WAITTID: usize = 1002;
const SYSCALL_MUTEX_CREATE: usize = 1010;
const SYSCALL_MUTEX_LOCK: usize = 1011;
const SYSCALL_MUTEX_UNLOCK: usize = 1012;
const SYSCALL_SEMAPHORE_CREATE: usize = 1020;
const SYSCALL_SEMAPHORE_UP: usize = 1021;
const SYSCALL_SEMAPHORE_DOWN: usize = 1022;
const SYSCALL_CONDVAR_CREATE: usize = 1030;
const SYSCALL_CONDVAR_SIGNAL: usize = 1031;
const SYSCALL_CONDVAR_WAIT: usize = 1032;

const SYSCALL_SIGACTION: usize = 134;
const SYSCALL_SIGPROCMASK: usize = 135;
const SYSCALL_SIGTIMEDWAIT: usize = 137;
const SYSCALL_SIGRETURN: usize = 139;
const SYSCALL_GETITIMER: usize = 102;
const SYSCALL_SETITIMER: usize = 103;
const SYSCALL_CLOCK_GETTIME: usize = 113;
const SYSCALL_PRLIMIT64: usize = 261;
const SYSCALL_SENDTO: usize = 206;
const SYSCALL_RECVFROM: usize = 207;
const SYSCALL_STATFS: usize = 43;
const SYSCALL_FUTEX: usize = 98;
const SYSCALL_TKILL: usize = 130;
const SYSCALL_SET_TID_ADDRESS: usize = 96;
const SYSCALL_READV: usize = 65;
const_def!(SYSCALL_WRITEV, 66);
const SYSCALL_PREAD64: usize = 67;
const SYSCALL_LSEEK: usize = 62;
const SYSCALL_NEW_FSTATAT: usize = 79;
const SYSCALL_FCNTL: usize = 25;
const SYSCALL_PPOLL: usize = 73;
const SYSCALL_SETPGID: usize = 154;
const SYSCALL_GETPGID: usize = 155;
const SYSCALL_GETEUID: usize = 175;
const SYSCALL_READLINKAT: usize = 78;
const SYSCALL_GETRUSAGE: usize = 165;

// first to support
const SYSCALL_MPROTECT: usize = 226;
const SYSCALL_GET_UID: usize = 174;
const SYSCALL_SYSINFO: usize = 179;
const SYSCALL_SEND_FILE: usize = 71;
const SYSCALL_FACCESSAT: usize = 48;
const SYSCALL_PSELECT: usize = 72;

const_def!(SYSCALL_EXIT_GROUP, 94);
const_def!(SYSCALL_GET_TID, 178);

// not standard sys call
const SYSCALL_HEAP_SPACE: usize = 550;

mod errno;
mod fs;
mod net;
mod process;
mod sync;
mod thread;
mod utils;

pub fn syscall(syscall_id: usize, args: [usize; 6]) -> isize {
    // if ![SYSCALL_WRITE, SYSCALL_READ, SYSCALL_PPOLL, SYSCALL_WRITEV, SYSCALL_CLOCK_GETTIME, SYSCALL_GETRUSAGE].contains(&syscall_id) {
    //     println!(
    //         "{} args:{:x?} pid: {}, [",
    //         color!(format!("syscall id: {}", syscall_id), INFO),
    //         args,
    //         current_process().getpid(),
    //     );
    // }

    let ret = match syscall_id {
        SYSCALL_DUP => sys_dup(args[0]),
        SYSCALL_DUP3 => sys_dup3(args[0], args[1]),
        SYSCALL_OPEN => sys_open(args[0] as isize, args[1] as *const u8, args[2] as u32),
        SYSCALL_CLOSE => sys_close(args[0]),
        SYSCALL_PIPE => sys_pipe(args[0] as *mut u32, args[1] as _),
        SYSCALL_READ => sys_read(args[0], args[1] as *const u8, args[2]),
        SYSCALL_WRITE => sys_write(args[0], args[1] as *const u8, args[2]),
        SYSCALL_EXIT => sys_exit(args[0] as i32),
        SYSCALL_SLEEP => sys_sleep(args[0] as *const u64, args[1] as *mut u64),
        SYSCALL_YIELD => sys_yield(),
        SYSCALL_KILL => sys_kill(args[0], args[1] as u64),
        SYSCALL_GET_TIME_OF_DAY => sys_get_time_of_day(args[0] as *mut u64),
        SYSCALL_GETPID => sys_getpid(),
        SYSCALL_GET_PPID => sys_getppid(),
        //SYSCALL_CLONE => sys_fork(),
        SYSCALL_IOCTL => sys_ioctl(args[0], args[1]),
        SYSCALL_CLONE => sys_clone(args[0], args[1], args[2], args[3], args[4]),
        SYSCALL_EXEC => sys_exec(args[0] as *const u8, args[1] as *const usize),
        SYSCALL_WAITPID => sys_waitpid(args[0] as isize, args[1] as *mut i32, args[2] as isize),
        SYSCALL_THREAD_CREATE => sys_thread_create(args[0], args[1]),
        SYSCALL_GET_TID => sys_gettid(),
        SYSCALL_WAITTID => sys_waittid(args[0]) as isize,
        SYSCALL_MUTEX_CREATE => sys_mutex_create(args[0] == 1),
        SYSCALL_MUTEX_LOCK => sys_mutex_lock(args[0]),
        SYSCALL_MUTEX_UNLOCK => sys_mutex_unlock(args[0]),
        SYSCALL_SEMAPHORE_CREATE => sys_semaphore_create(args[0]),
        SYSCALL_SEMAPHORE_UP => sys_semaphore_up(args[0]),
        SYSCALL_SEMAPHORE_DOWN => sys_semaphore_down(args[0]),
        SYSCALL_CONDVAR_CREATE => sys_condvar_create(args[0]),
        SYSCALL_CONDVAR_SIGNAL => sys_condvar_signal(args[0]),
        SYSCALL_CONDVAR_WAIT => sys_condvar_wait(args[0], args[1]),
        SYSCALL_SIGACTION => sys_sigaction(args[0], args[1] as *mut usize, args[2] as *mut usize),
        SYSCALL_SIGPROCMASK => sys_sigprocmask(args[0], args[1] as _, args[2] as _),
        //SYSCALL_SIGTIMEDWAIT => sys_sigtimedwait(args[0] as *mut u32, args[1] as *mut usize, args[2] as *mut usize),
        SYSCALL_SIGRETURN => sys_sigreturn(),
        SYSCALL_GETCWD => sys_get_cwd(args[0] as *mut u8, args[1]),
        SYSCALL_CHDIR => sys_chdir(args[0] as *const u8),
        SYSCALL_GET_DENTS64 => {
            sys_getdents64(args[0] as isize, args[1] as *const u8, args[2] as usize)
        }
        SYSCALL_LINK_AT => 0,
        SYSCALL_UNLINK_AT => sys_unlink(args[0] as isize, args[1] as *const u8, args[2] as u32),
        SYSCALL_MKDIR_AT => sys_mkdir(args[0] as isize, args[1] as *const u8, args[2] as u32),
        SYSCALL_UMOUNT2 => sys_umount(args[0] as *const u8, args[1] as usize),
        SYSCALL_MOUNT => sys_mount(
            args[0] as *const u8,
            args[1] as *const u8,
            args[2] as *const u8,
            args[3] as usize,
            args[4] as *const u8,
        ),
        SYSCALL_FSTAT => sys_fstat(args[0] as isize, args[1] as *const u8),
        // SYSCALL_UTIMENSAT => sys_utimensat(
        //     args[0] as isize,
        //     args[1] as *const u8,
        //     args[2] as *const usize,
        //     args[3] as u32,
        // ),
        SYSCALL_BRK => sys_brk(args[0]),
        SYSCALL_MUNMAP => sys_munmap(args[0], args[1]),
        SYSCALL_MMAP => sys_mmap(
            args[0],
            args[1],
            args[2],
            args[3],
            args[4] as isize,
            args[5],
        ),
        SYSCALL_TIMES => sys_get_times(args[0] as *mut u64),
        SYSCALL_UNAME => sys_uname(args[0] as *mut u8),
        SYSCALL_SET_TID_ADDRESS => sys_set_tid_address(args[0]),
        SYSCALL_MPROTECT => sys_mprotect(args[0], args[1], args[2] as usize),
        // SYSCALL_FUTEX => sys_futex(args[0], args[1], args[2], args[3], args[4], args[5]),
        SYSCALL_TKILL => sys_tkill(args[0], args[1]),
        SYSCALL_GET_UID => sys_get_uid(),
        SYSCALL_NEW_FSTATAT => sys_new_fstatat(
            args[0] as isize,
            args[1] as *const u8,
            args[2] as *mut u8,
            args[3] as isize,
        ),
        SYSCALL_EXIT_GROUP => sys_exit_group(args[0] as i32),
        SYSCALL_WRITEV => sys_writev(args[0], args[1], args[2]),
        SYSCALL_READV => sys_readv(args[0], args[1], args[2]),
        SYSCALL_UTIMENSAT => sys_utimensat(
            args[0] as isize,
            args[1] as *const u8,
            args[2] as *const TimeSpec,
            args[3] as isize,
        ),
        SYSCALL_PRLIMIT64 => sys_prlimit(
            args[0],
            args[1],
            args[2] as *const RLimit64,
            args[3] as *mut RLimit64,
        ),
        //SYSCALL_SYSFS => sys_fs(args[0], args[1], args[2]),
        SYSCALL_GETITIMER => sys_getitimer(args[0] as isize, args[1] as usize),
        SYSCALL_SETITIMER => sys_setitimer(args[0] as isize, args[1] as _, args[2] as _),
        SYSCALL_CLOCK_GETTIME => sys_clock_gettime(args[0] as isize, args[1] as *mut usize),
        SYSCALL_LSEEK => sys_lseek(args[0] as isize, args[1] as isize, args[2] as i32),
        SYSCALL_FCNTL => sys_fcntl(args[0], args[1] as u32, args[2] as _),
        SYSCALL_SENDTO => sys_sendto(
            args[0] as isize,
            args[1] as *const u8,
            args[2],
            args[3] as isize,
            args[4],
            args[5],
        ),
        SYSCALL_RECVFROM => sys_recvfrom(
            args[0] as isize,
            args[1] as *const u8,
            args[2],
            args[3] as isize,
            args[4],
            args[5],
        ),
        SYSCALL_STATFS => sys_statfs(args[0] as _, args[1] as _),
        SYSCALL_PREAD64 => sys_pread64(args[0], args[1] as *mut u8, args[2], args[3]),
        SYSCALL_SETPGID => sys_setpgid(args[0], args[1]),
        SYSCALL_GETPGID => sys_getpgid(args[0]),
        SYSCALL_GETEUID => sys_geteuid(),
        SYSCALL_PPOLL => sys_ppoll(args[0] as _, args[1] as _, args[2] as _, args[3] as _),
        SYSCALL_SYSINFO => sys_sysinfo(args[0] as _),
        SYSCALL_SEND_FILE => sys_sendfile(args[0] as _, args[1] as _, args[2] as _, args[3] as _),
        SYSCALL_FACCESSAT => sys_faccessat(args[0] as _, args[1] as _, args[2] as _, args[3] as _),
        SYSCALL_PSELECT => sys_pselect(
            args[0] as _,
            args[1] as _,
            args[2] as _,
            args[3] as _,
            args[4] as _,
        ),
        SYSCALL_READLINKAT => {
            sys_readlinkat(args[0] as _, args[1] as _, args[2] as _, args[3] as _)
        }
        SYSCALL_GETRUSAGE => sys_getrusage(args[0] as _, args[1] as _),
        //SYSCALL_HEAP_SPACE => crate::mm::get_rest(),
        501 | 65535 => {
            println!("!TEST FINISH!");
            shutdown();
        }
        //_ => panic!("Unsupported syscall_id: {}", syscall_id),
        _ => {
            let log = color!(format!("unsupported syscall id {}", syscall_id), ERROR);
            println!("{}", log);
            0
        } //_ => 0,
    };
    //if [SYSCALL_WRITE, SYSCALL_READ].contains(&syscall_id).not() {
    //    println!("syscall_id: {}, args: {:x?} ,ret={}", syscall_id, args, ret);
    //}
    
    if ![SYSCALL_WRITE, SYSCALL_READ, SYSCALL_PPOLL, SYSCALL_WRITEV, SYSCALL_CLOCK_GETTIME, SYSCALL_GETRUSAGE].contains(&syscall_id) {
        println!(
            "{} args:{:x?}, pid: {} ret: {} ]",
            color!(format!("syscall id: {}", syscall_id), INFO),
            args,
            current_process().getpid(),
            ret
        );
    }
    
    ret
}
