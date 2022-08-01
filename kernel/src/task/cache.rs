use alloc::vec::Vec;

use lazy_static::lazy_static;

use crate::fs_fat::{FileType, open_file, OpenFlags};
use crate::UPIntrFreeCell;

lazy_static! {
    pub static ref TEST_SH_DATA: UPIntrFreeCell<Vec<u8>> =
        unsafe { UPIntrFreeCell::new(load_test_sh()) };
}

fn load_test_sh() -> Vec<u8> {
    let file = open_file("/", "runtest.exe", OpenFlags::RDONLY, FileType::Regular).unwrap();
    file.read_all()
}

lazy_static! {
    pub static ref ENTRY_STATIC_DATA: UPIntrFreeCell<Vec<u8>> =
        unsafe { UPIntrFreeCell::new(load_entry_static()) };
}

fn load_entry_static() -> Vec<u8> {
    let file = open_file(
        "/",
        "entry-static.exe",
        OpenFlags::RDONLY,
        FileType::Regular,
    )
        .unwrap();
    file.read_all()
}
