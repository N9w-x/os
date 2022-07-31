#[allow(unused)]
pub use crate::board::{CLOCK_FREQ, MMIO};

pub const USER_STACK_SIZE: usize = 4096 * 6;
//0x2000
pub const KERNEL_STACK_SIZE: usize = 4096 * 2;
pub const KERNEL_HEAP_SIZE: usize = PAGE_SIZE * 0x300;
//
pub const MEMORY_END: usize = 0x8080_0000;
pub const PAGE_SIZE: usize = 0x1000;
pub const PAGE_SIZE_BITS: usize = 0xc;

pub const TRAMPOLINE: usize = usize::MAX - PAGE_SIZE + 1;
pub const TRAP_CONTEXT_BASE: usize = TRAMPOLINE - PAGE_SIZE;

pub const USER_STACK_BASE: usize = 0x1_0000_0000;
pub const MEMORY_MAP_BASE: usize = 0x8000_0000;

pub const FD_MAX: usize = 128;

#[macro_export]
macro_rules! const_def {
    ($ident:ident, $val:expr) => {
        pub const $ident: usize = $val;
    };
}

// mmap flag
const_def!(MAP_FILE, 0);
const_def!(MAP_SHARED, 0x01);
const_def!(MAP_PRIVATE, 0x02);
const_def!(MAP_SHARED_VALIDATE, 0x03);
const_def!(MAP_TYPE, 0x0f);
const_def!(MAP_FIXED, 0x10);
const_def!(MAP_ANON, 0x20);
const_def!(MAP_ANONYMOUS, MAP_ANON);
const_def!(MAP_NORESERVE, 0x4000);
const_def!(MAP_GROWSDOWN, 0x0100);
const_def!(MAP_DENYWRITE, 0x0800);
const_def!(MAP_EXECUTABLE, 0x1000);
const_def!(MAP_LOCKED, 0x2000);
const_def!(MAP_POPULATE, 0x8000);
const_def!(MAP_NONBLOCK, 0x10000);
const_def!(MAP_STACK, 0x20000);
const_def!(MAP_HUGETLB, 0x40000);
const_def!(MAP_SYNC, 0x80000);
const_def!(MAP_FIXED_NOREPLACE, 0x100000);

//aux typ
const_def!(AT_NULL, 0);
const_def!(AT_IGNORE, 1);
const_def!(AT_EXECCFD, 2);
const_def!(AT_PHDR, 3);
const_def!(AT_PHENT, 4);
const_def!(AT_PHNUM, 5);
const_def!(AT_PAGESIZE, 6);
const_def!(AT_BASE, 7);
const_def!(AT_FLAGS, 8);
const_def!(AT_ENTRY, 9);
const_def!(AT_NOELF, 10);
const_def!(AT_UID, 11);
const_def!(AT_EUID, 12);
const_def!(AT_GID, 13);
const_def!(AT_EGID, 14);
const_def!(AT_PLATFORM, 15);
const_def!(AT_HWCAP, 16);
const_def!(AT_CLKTCK, 17);
const_def!(AT_SECURE, 23);
const_def!(AT_BASE_PLATFORM, 24);
const_def!(AT_RANDOM, 25);
const_def!(AT_HWCAP2, 26);
const_def!(AT_EXECFN, 31);
const_def!(AT_SYSINFO, 32);
const_def!(AT_SYSINFO_EHDR, 33);


const_def!(RLIMIT_CPU, 0);
const_def!(RLIMIT_FSIZE, 1);
const_def!(RLIMIT_DATA, 2);
const_def!(RLIMIT_STACK, 3);
const_def!(RLIMIT_CORE, 4);
const_def!(RLIMIT_RSS, 5);
const_def!(RLIMIT_NPROC, 6);
const_def!(RLIMIT_NOFILE, 7);
const_def!(RLIMIT_MEMLOCK, 8);
const_def!(RLIMIT_AS, 9);
const_def!(RLIMIT_LOCKS, 10);
const_def!(RLIMIT_SIGPENDING, 11);
const_def!(RLIMIT_MSGQUEUE, 12);
const_def!(RLIMIT_NICE, 13);
const_def!(RLIMIT_RTPRIO, 14);
const_def!(RLIMIT_RTTIME, 15);
const_def!(RLIM_NLIMITS, 16);