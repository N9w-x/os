#![allow(non_snake_case)]

use bitflags::*;

pub struct SignalStruct {
    pub actions: [Option<SigAction>; 64],
}

impl Default for SignalStruct {
    fn default() -> Self {
        Self {
            actions: [None; 64],
        }
    }
}

bitflags! {
    pub struct Signum: u32 {
        const	SIGHUP		= 1 << ( 1-1);
        const	SIGINT		= 1 << ( 2-1);
        const	SIGQUIT		= 1 << ( 3-1);
        const	SIGILL		= 1 << ( 4-1);
        const	SIGTRAP		= 1 << ( 5-1);
        const	SIGABRT		= 1 << ( 6-1);
        const	SIGIOT		= 1 << ( 6-1);
        const	SIGBUS		= 1 << ( 7-1);
        const	SIGFPE		= 1 << ( 8-1);
        const	SIGKILL		= 1 << ( 9-1);
        const	SIGUSR1		= 1 << (10-1);
        const	SIGSEGV		= 1 << (11-1);
        const	SIGUSR2		= 1 << (12-1);
        const	SIGPIPE		= 1 << (13-1);
        const	SIGALRM		= 1 << (14-1);
        const	SIGTERM		= 1 << (15-1);
        const	SIGSTKFLT	= 1 << (16-1);
        const	SIGCHLD		= 1 << (17-1);
        const	SIGCONT		= 1 << (18-1);
        const	SIGSTOP		= 1 << (19-1);
        const	SIGTSTP		= 1 << (20-1);
        const	SIGTTIN		= 1 << (21-1);
        const	SIGTTOU		= 1 << (22-1);
        const	SIGURG		= 1 << (23-1);
        const	SIGXCPU		= 1 << (24-1);
        const	SIGXFSZ		= 1 << (25-1);
        const	SIGVTALRM	= 1 << (26-1);
        const	SIGPROF		= 1 << (27-1);
        const	SIGWINCH	= 1 << (28-1);
        const	SIGIO		= 1 << (29-1);
    }
}

impl Signum {
    pub fn check_error(&self) -> Option<(i32, &'static str)> {
        if self.contains(Self::SIGINT) {
            Some((-2, "Killed, SIGINT=2"))
        } else if self.contains(Self::SIGILL) {
            Some((-4, "Illegal Instruction, SIGILL=4"))
        } else if self.contains(Self::SIGABRT) {
            Some((-6, "Aborted, SIGABRT=6"))
        } else if self.contains(Self::SIGFPE) {
            Some((-8, "Erroneous Arithmetic Operation, SIGFPE=8"))
        } else if self.contains(Self::SIGSEGV) {
            Some((-11, "Segmentation Fault, SIGSEGV=11"))
        } else {
            None
        }
    }
}

#[derive(Copy, Clone, Default)]
pub struct SigAction {
    pub sa_handler: Option<fn(isize)>,
    pub sa_sigaction: Option<fn(isize, SigInfo, *mut SigInfo)>,
    pub sa_mask: [usize; 16],
    pub sa_flags: usize,
    pub sa_restorer: Option<fn()>,
}

/// 默认处理
pub fn SIG_DFL(signum: isize) {}
/// 忽略该信号
pub fn SIG_IGN(signum: isize) {}
/// 错误
pub fn SIG_ERR(signum: isize) {}

pub struct SigInfo {}

pub struct SaFlags {}
