use alloc::format;
use core::fmt::{self, Write};

use crate::sbi::{console_getchar, console_putchar};

struct Stdout;

impl Write for Stdout {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        for c in s.chars() {
            //UART.write(c as u8);
            console_putchar(c as usize)
        }
        Ok(())
    }
}

pub fn print(args: fmt::Arguments) {
    Stdout.write_fmt(args).unwrap();
}

#[macro_export]
macro_rules! print {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!($fmt $(, $($arg)+)?))
    }
}

#[macro_export]
macro_rules! println {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?))
    }
}

macro_rules! eprintln {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?))
    }
}

#[macro_export]
macro_rules! dbg {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        if cfg!(feature = "board_qemu") {
            $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?))
        }
    }
}

#[macro_export]
macro_rules! color {
    ($template:expr,$color:expr) => {
        format!("\x1b[{}m{}\x1b[0m", $color, $template)
    };
}

pub const WARNING: usize = 33;
pub const INFO: usize = 32;
pub const ERROR: usize = 31;
