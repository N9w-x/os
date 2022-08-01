use alloc::collections::BTreeMap;
use alloc::sync::Arc;
use alloc::vec;
use alloc::vec::Vec;
use core::arch::asm;
use core::fmt::{Display, Formatter};

use lazy_static::*;
use riscv::register::satp;
use xmas_elf::ElfFile;

use crate::config::{
    AT_BASE, AT_CLKTCK, AT_EGID, AT_ENTRY, AT_EUID, AT_FLAGS, AT_GID, AT_HWCAP, AT_NOELF,
    AT_PAGESIZE, AT_PHDR, AT_PHENT, AT_PHNUM, AT_PLATFORM, AT_SECURE, AT_UID, CLOCK_FREQ,
    MEMORY_END, MMIO, PAGE_SIZE, TRAMPOLINE, USER_STACK_BASE, MAP_ANONYMOUS, SIGRETURN_TRAMPOLINE,
    MAP_FIXED,
};
use crate::const_def;
use crate::fs_fat::{File, FileDescriptor, FileType, open_file, OpenFlags};
use crate::sync::UPIntrFreeCell;

use super::{frame_alloc, FrameTracker, translated_byte_buffer, UserBuffer};
use super::{PageTable, PageTableEntry, PTEFlags};
use super::{PhysAddr, PhysPageNum, VirtAddr, VirtPageNum};
use super::{StepByOne, VPNRange};

extern "C" {
    fn stext();
    fn etext();
    fn srodata();
    fn erodata();
    fn sdata();
    fn edata();
    fn sbss_with_stack();
    fn ebss();
    fn ekernel();
    fn strampoline();
}

lazy_static! {
    pub static ref KERNEL_SPACE: Arc<UPIntrFreeCell<MemorySet>> =
        Arc::new(unsafe { UPIntrFreeCell::new(MemorySet::new_kernel()) });
}

pub fn kernel_token() -> usize {
    KERNEL_SPACE.exclusive_access().token()
}

pub struct MemorySet {
    page_table: PageTable,
    areas: Vec<MapArea>,
    heap: BTreeMap<VirtPageNum, FrameTracker>,
    pub mmap_areas: Vec<MemoryMapArea>,
}

impl MemorySet {
    pub fn set_mem_flags(&mut self, vpn: VirtPageNum, flags: usize) -> isize {
        const PROT_NONE: usize = 0;
        const PROT_READ: usize = 1;
        const PROT_WRITE: usize = 2;
        const PROT_EXEC: usize = 4;
        
        let pte_res = self.set_pte_flags(vpn, flags);
        let mut map_area_res = -1;
        for area in &mut self.areas {
            if area.vpn_range.contain(vpn) {
                let mut map_perm = MapPermission::U;
                if (flags & PROT_READ) != 0 {
                    map_perm |= MapPermission::R
                }
                if flags & PROT_WRITE != 0 {
                    map_perm |= MapPermission::W
                }
                if flags & PROT_EXEC != 0 {
                    map_perm |= MapPermission::X
                }
                
                area.map_perm = map_perm;
                break;
            }
        }
        
        if map_area_res == -1 || pte_res == -1 {
            -1
        } else {
            0
        }
    }
    
    fn set_pte_flags(&mut self, vpn: VirtPageNum, flags: usize) -> isize {
        self.page_table.set_pte_flags(vpn, flags)
    }
    
    pub fn new_bare() -> Self {
        Self {
            page_table: PageTable::new(),
            areas: Vec::new(),
            heap: BTreeMap::new(),
            mmap_areas: Vec::new(),
        }
    }

    pub fn token(&self) -> usize {
        self.page_table.token()
    }

    /// Assume that no conflicts.
    pub fn insert_framed_area(
        &mut self,
        start_va: VirtAddr,
        end_va: VirtAddr,
        permission: MapPermission,
    ) {
        self.push(
            MapArea::new(start_va, end_va, MapType::Framed, permission),
            None,
        );
    }

    pub fn remove_area_with_start_vpn(&mut self, start_vpn: VirtPageNum) {
        if let Some((idx, area)) = self
            .areas
            .iter_mut()
            .enumerate()
            .find(|(_, area)| area.vpn_range.get_start() == start_vpn)
        {
            area.unmap(&mut self.page_table);
            self.areas.remove(idx);
        }
    }

    fn push(&mut self, mut map_area: MapArea, data: Option<&[u8]>) {
        map_area.map(&mut self.page_table);
        if let Some(data) = data {
            map_area.copy_data(&mut self.page_table, data, 0);
        }
        self.areas.push(map_area);
    }

    fn push_with_offset(&mut self, mut map_area: MapArea, offset: usize, data: Option<&[u8]>) {
        map_area.map(&mut self.page_table);
        if let Some(data) = data {
            map_area.copy_data(&mut self.page_table, data, offset)
        }
        self.areas.push(map_area);
    }

    /// Mention that trampoline is not collected by areas.
    fn map_trampoline(&mut self) {
        self.page_table.map(
            VirtAddr::from(TRAMPOLINE).into(),
            PhysAddr::from(strampoline as usize).into(),
            PTEFlags::R | PTEFlags::X,
        );
    }

    fn map_sigreturn_trampoline(&mut self) {
        self.page_table.map(
            VirtAddr::from(SIGRETURN_TRAMPOLINE).into(),
            PhysAddr::from(strampoline as usize).into(),
            PTEFlags::R | PTEFlags::X | PTEFlags::U,
        );
    }

    /// Without kernel stacks.
    pub fn new_kernel() -> Self {
        let mut memory_set = Self::new_bare();
        // map trampoline
        memory_set.map_trampoline();
        // map kernel sections
        println!(".text [{:#x}, {:#x})", stext as usize, etext as usize);
        println!(".rodata [{:#x}, {:#x})", srodata as usize, erodata as usize);
        println!(".data [{:#x}, {:#x})", sdata as usize, edata as usize);
        println!(
            ".bss [{:#x}, {:#x})",
            sbss_with_stack as usize, ebss as usize
        );
        println!("mapping .text section");
        memory_set.push(
            MapArea::new(
                (stext as usize).into(),
                (etext as usize).into(),
                MapType::Identical,
                MapPermission::R | MapPermission::X,
            ),
            None,
        );
        println!("mapping .rodata section");
        memory_set.push(
            MapArea::new(
                (srodata as usize).into(),
                (erodata as usize).into(),
                MapType::Identical,
                MapPermission::R,
            ),
            None,
        );
        println!("mapping .data section");
        memory_set.push(
            MapArea::new(
                (sdata as usize).into(),
                (edata as usize).into(),
                MapType::Identical,
                MapPermission::R | MapPermission::W,
            ),
            None,
        );
        println!("mapping .bss section");
        memory_set.push(
            MapArea::new(
                (sbss_with_stack as usize).into(),
                (ebss as usize).into(),
                MapType::Identical,
                MapPermission::R | MapPermission::W,
            ),
            None,
        );
        println!("mapping physical memory");
        memory_set.push(
            MapArea::new(
                (ekernel as usize).into(),
                MEMORY_END.into(),
                MapType::Identical,
                MapPermission::R | MapPermission::W,
            ),
            None,
        );
        println!("mapping memory-mapped registers");
        for pair in MMIO {
            memory_set.push(
                MapArea::new(
                    (*pair).0.into(),
                    ((*pair).0 + (*pair).1).into(),
                    MapType::Identical,
                    MapPermission::R | MapPermission::W,
                ),
                None,
            );
        }
        memory_set
    }

    // 动态链接程序装载interpreter
    // (entry_point,base_va)
    fn map_interpreter(&mut self) -> (usize, usize) {
        let file = open_file("/", "libc.so", OpenFlags::RDWR, FileType::Regular).unwrap();
        let data = file.read_all();
    
        let ld_elf = ElfFile::new(&data).unwrap();
        let ld_header = ld_elf.header;
        let magic = ld_header.pt1.magic;
        assert_eq!(magic, [0x7f, 0x45, 0x4c, 0x46], "not valid elf");
    
        let mut head_va = 0usize;
        let base = 0x2000_000usize;
    
        for ph in ld_elf.program_iter() {
            if ph.get_type().unwrap() == xmas_elf::program::Type::Load {
                let start_va = VirtAddr::from(ph.virtual_addr() as usize + base);
                let end_va = VirtAddr::from(start_va.0 + ph.mem_size() as usize);
                let offset = start_va.0 - start_va.floor().0 * PAGE_SIZE;
                if head_va == 0 {
                    head_va = start_va.0
                }

                let perm = ph.flags();
                let mut map_perm = MapPermission::U;
                if perm.is_read() {
                    map_perm |= MapPermission::R
                }
                if perm.is_write() {
                    map_perm |= MapPermission::W
                }
                if perm.is_execute() {
                    map_perm |= MapPermission::X
                }

                let map_area = MapArea::new(start_va, end_va, MapType::Framed, map_perm);
                self.push_with_offset(
                    map_area,
                    offset,
                    Some(
                        &ld_elf.input
                            [ph.offset() as usize..(ph.offset() + ph.file_size()) as usize],
                    ),
                )
            }
        }

        (ld_header.pt2.entry_point() as usize + base, base)
    }
    
    /// Include sections in elf and trampoline,
    /// also returns user_sp_base and entry point.
    /// return (memory set,user heap base, user stack base,exec entry )
    pub fn from_elf(elf_data: &[u8]) -> (Self, usize, usize, usize, Vec<AuxHeader>) {
        let mut memory_set = Self::new_bare();
        // map trampoline
        memory_set.map_sigreturn_trampoline();
        memory_set.map_trampoline();
        // map program headers of elf, with U flag
        let elf = xmas_elf::ElfFile::new(elf_data).unwrap();
        let elf_header = elf.header;

        let mut auxv = vec![
            AuxHeader::new(AT_PHENT, elf_header.pt2.ph_entry_size() as usize),
            AuxHeader::new(AT_PHNUM, elf_header.pt2.ph_count() as usize),
            AuxHeader::new(AT_PAGESIZE, PAGE_SIZE as usize),
            AuxHeader::new(AT_FLAGS, 0),
            AuxHeader::new(AT_ENTRY, elf_header.pt2.entry_point() as usize),
            AuxHeader::new(AT_UID, 0),
            AuxHeader::new(AT_EUID, 0),
            AuxHeader::new(AT_GID, 0),
            AuxHeader::new(AT_EGID, 0),
            AuxHeader::new(AT_PLATFORM, 0),
            AuxHeader::new(AT_HWCAP, 0),
            AuxHeader::new(AT_CLKTCK, 100usize),
            AuxHeader::new(AT_SECURE, 0),
            AuxHeader::new(AT_NOELF, 0x112d),
        ];

        let mut entry_point = elf_header.pt2.entry_point() as usize;
        let mut head_va: usize = 0;
        let ph_count = elf_header.pt2.ph_count();
        let mut max_end_vpn = VirtPageNum(0);
        
        for ph in elf.program_iter() {
            if ph.get_type().unwrap() == xmas_elf::program::Type::Load {
                let start_va: VirtAddr = (ph.virtual_addr() as usize).into();
                let end_va: VirtAddr = ((ph.virtual_addr() + ph.mem_size()) as usize).into();
                let offset = start_va.0 - start_va.floor().0 * PAGE_SIZE;
    
                let mut map_perm = MapPermission::U;
                let ph_flags = ph.flags();
                if head_va == 0 {
                    head_va = start_va.0;
                }
                if ph_flags.is_read() {
                    map_perm |= MapPermission::R;
                }
                if ph_flags.is_write() {
                    map_perm |= MapPermission::W;
                }
                if ph_flags.is_execute() {
                    map_perm |= MapPermission::X;
                }

                let map_area = MapArea::new(start_va, end_va, MapType::Framed, map_perm);
                max_end_vpn = map_area.vpn_range.get_end();
    
                if offset == 0 {
                    memory_set.push(
                        map_area,
                        Some(
                            &elf.input
                                [ph.offset() as usize..(ph.offset() + ph.file_size()) as usize],
                        ),
                    )
                } else {
                    memory_set.push_with_offset(
                        map_area,
                        offset,
                        Some(
                            &elf.input
                                [ph.offset() as usize..(ph.offset() + ph.file_size()) as usize],
                        ),
                    );
                }
            }
        }
        
        let base_va = if elf.find_section_by_name(".interp").is_some() {
            let mut t = 0;
            (entry_point, t) = memory_set.map_interpreter();
            t
        } else {
            0
        };
        auxv.push(AuxHeader::new(AT_BASE, base_va));
        
        //get ph_head addr
        auxv.push(AuxHeader::new(
            AT_PHDR,
            head_va + elf_header.pt2.ph_offset() as usize,
        ));
        
        let max_end_va: VirtAddr = max_end_vpn.into();
        let mut user_heap_base: usize = max_end_va.into();
        user_heap_base += PAGE_SIZE;
        let user_stack_base = USER_STACK_BASE;
        //memory_set.print_map_area();
        (
            memory_set,
            user_heap_base,
            user_stack_base,
            entry_point,
            auxv,
        )
    }

    pub fn from_existed_user(user_space: &MemorySet) -> MemorySet {
        let mut memory_set = Self::new_bare();
        // map trampoline
        memory_set.map_sigreturn_trampoline();
        memory_set.map_trampoline();
        // copy data sections/trap_context/user_stack
        for area in user_space.areas.iter() {
            let new_area = MapArea::from_another(area);
            memory_set.push(new_area, None);
            // copy data from another space
            for vpn in area.vpn_range {
                let src_ppn = user_space.translate(vpn).unwrap().ppn();
                let dst_ppn = memory_set.translate(vpn).unwrap().ppn();
                dst_ppn
                    .get_bytes_array()
                    .copy_from_slice(src_ppn.get_bytes_array());
            }
        }
        // // copy heap
        // for (vpn, src_frame) in user_space.heap.iter() {
        //     let dst_frame = frame_alloc().unwrap();
        //     let dst_ppn = dst_frame.ppn;
        //     memory_set.page_table.map(*vpn, dst_ppn, PTEFlags::U | PTEFlags::R | PTEFlags::W);
        //     memory_set.heap.insert(*vpn, dst_frame);

        //     let src_ppn = src_frame.ppn;
        //     // copy data
        //     dst_ppn
        //         .get_bytes_array()
        //         .copy_from_slice(src_ppn.get_bytes_array());
        // }
        // // copy mmap
        // for mmap_area in user_space.mmap_areas.iter() {
        //     let mut new_mmap_area = MemoryMapArea::from_another(mmap_area);
        //     for vpn in mmap_area.vpn_range {
        //         if let Some(pte) = user_space.translate(vpn) {// lazy可能未分配内存
        //             let src_ppn = pte.ppn();
        //             let frame = frame_alloc().unwrap();
        //             let dst_ppn = frame.ppn;
        //             // copy data
        //             dst_ppn
        //                 .get_bytes_array()
        //                 .copy_from_slice(src_ppn.get_bytes_array());
        //             new_mmap_area.data_frames.insert(vpn, frame);
        //         }
        //     }

        // }
        memory_set
    }
    
    pub fn activate(&self) {
        let satp = self.page_table.token();
        unsafe {
            satp::write(satp);
            asm!("sfence.vma");
        }
    }
    
    pub fn translate(&self, vpn: VirtPageNum) -> Option<PageTableEntry> {
        self.page_table.translate(vpn)
    }
    
    pub fn recycle_data_pages(&mut self) {
        //*self = Self::new_bare();
        self.areas.clear();
    }
    
    pub fn print_map_area(&self) {
        for area in &self.areas {
            println!("{:#}", area);
        }
    }

    pub fn print_mmap_area(&self) {
        for area in &self.mmap_areas {
            println!("{:#}", area);
        }
    }
    
    pub fn insert_mmap_area(&mut self, mmap_area: MemoryMapArea) {
        self.mmap_areas.push(mmap_area);
    }
    
    pub fn remove_mmap_area(&mut self, start_vpn: VirtPageNum) -> bool {
        if let Some((idx, area)) = self
            .mmap_areas
            .iter_mut()
            .enumerate()
            .find(|(_, area)| area.vpn_range.get_start() == start_vpn)
        {
            area.unmap(&mut self.page_table);
            self.mmap_areas.remove(idx);
            true
        } else {
            false
        }
    }
    
    pub fn lazy_alloc_heap(&mut self, va: VirtAddr) -> bool {
        let vpn: VirtPageNum = va.floor();
        let frame = frame_alloc().unwrap();
        let ppn = frame.ppn;
        self.page_table
            .map(vpn, ppn, PTEFlags::U | PTEFlags::R | PTEFlags::W);
        self.heap.insert(vpn, frame);
        true
    }
    
    pub fn lazy_alloc_mmap_area(
        &mut self,
        va: VirtAddr,
        // fd_table: Vec<Option<FileDescriptor>>,
    ) -> bool {
        let vpn: VirtPageNum = va.floor();

        // println!("===========");
        // for ele in self.mmap_areas.iter() {
        //     println!("{:#x} - {:#x}", VirtAddr::from(ele.vpn_range.get_start()).0, VirtAddr::from(ele.vpn_range.get_end()).0);
        // }
        // println!("===========");

        if let Some(area) = self
            .mmap_areas
            .iter_mut()
            .find(|area| area.vpn_range.contain(vpn))
        {
            // return area.map_one(&mut self.page_table, vpn, fd_table);
            return area.map_one(&mut self.page_table, vpn);
        }
        false
    }

    /// 为所有页面分配内存
    /// 不映射文件
    pub fn alloc_mmap_area(&mut self, va: VirtAddr) {
        let vpn: VirtPageNum = va.floor();
        if let Some(area) = self
            .mmap_areas
            .iter_mut()
            .find(|area| area.vpn_range.contain(vpn))
        {
            // return area.map_one(&mut self.page_table, vpn, fd_table);
            return area.map(&mut self.page_table);
        }
    }

    // pub fn set_pte_flags(&self, vpn: VirtPageNum, flags: PTEFlags) -> bool {
    //     self.page_table.set_pte_flags(vpn, flags)
    // }
}

pub struct MapArea {
    vpn_range: VPNRange,
    data_frames: BTreeMap<VirtPageNum, FrameTracker>,
    map_type: MapType,
    map_perm: MapPermission,
}

impl MapArea {
    pub fn new(
        start_va: VirtAddr,
        end_va: VirtAddr,
        map_type: MapType,
        map_perm: MapPermission,
    ) -> Self {
        let start_vpn: VirtPageNum = start_va.floor();
        let end_vpn: VirtPageNum = end_va.ceil();
        Self {
            vpn_range: VPNRange::new(start_vpn, end_vpn),
            data_frames: BTreeMap::new(),
            map_type,
            map_perm,
        }
    }
    pub fn from_another(another: &MapArea) -> Self {
        Self {
            vpn_range: VPNRange::new(another.vpn_range.get_start(), another.vpn_range.get_end()),
            data_frames: BTreeMap::new(),
            map_type: another.map_type,
            map_perm: another.map_perm,
        }
    }
    pub fn map_one(&mut self, page_table: &mut PageTable, vpn: VirtPageNum) {
        let ppn: PhysPageNum;
        match self.map_type {
            MapType::Identical => {
                ppn = PhysPageNum(vpn.0);
            }
            MapType::Framed => {
                let frame = frame_alloc().unwrap();
                ppn = frame.ppn;
                self.data_frames.insert(vpn, frame);
            }
        }
        let pte_flags = PTEFlags::from_bits(self.map_perm.bits).unwrap();
        page_table.map(vpn, ppn, pte_flags);
    }
    pub fn unmap_one(&mut self, page_table: &mut PageTable, vpn: VirtPageNum) {
        if self.map_type == MapType::Framed {
            self.data_frames.remove(&vpn);
        }
        page_table.unmap(vpn);
    }
    pub fn map(&mut self, page_table: &mut PageTable) {
        for vpn in self.vpn_range {
            self.map_one(page_table, vpn);
        }
    }
    pub fn unmap(&mut self, page_table: &mut PageTable) {
        for vpn in self.vpn_range {
            self.unmap_one(page_table, vpn);
        }
    }
    
    /// data: start-aligned but maybe with shorter length
    /// assume that all frames were cleared before
    pub fn copy_data(&mut self, page_table: &mut PageTable, data: &[u8], offset: usize) {
        assert_eq!(self.map_type, MapType::Framed);
        let mut start: usize = 0;
        let mut page_offset = offset;
        let mut current_vpn = self.vpn_range.get_start();
        let len = data.len();
        loop {
            let src = &data[start..len.min(start + PAGE_SIZE - page_offset)];
            let dst = &mut page_table
                .translate(current_vpn)
                .unwrap()
                .ppn()
                .get_bytes_array()[page_offset..(page_offset + src.len())];
            dst.copy_from_slice(src);
            start += PAGE_SIZE - page_offset;
            page_offset = 0;
            if start >= len {
                break;
            }
            current_vpn.step();
        }
    }
}

impl Display for MapArea {
    fn fmt(&self, f: &mut Formatter<'_>) -> core::fmt::Result {
        let start_virt_addr = VirtAddr::from(self.vpn_range.get_start());
        let end_virt_addr = VirtAddr::from(self.vpn_range.get_end());
        write!(
            f,
            "{:<#16x}   {:<#16x}   {:#}",
            start_virt_addr.0, end_virt_addr.0, self.map_perm
        )
    }
}

#[derive(Copy, Clone, PartialEq, Eq, Debug)]
pub enum MapType {
    Identical,
    Framed,
}

bitflags! {
    pub struct MapPermission: u8 {
        const R = 1 << 1;
        const W = 1 << 2;
        const X = 1 << 3;
        const U = 1 << 4;
    }
}

impl Display for MapPermission {
    fn fmt(&self, f: &mut Formatter<'_>) -> core::fmt::Result {
        let (readable, writable, executable) = (
            self.contains(MapPermission::R),
            self.contains(MapPermission::W),
            self.contains(MapPermission::X),
        );
    
        let read = readable.then_some("R").unwrap_or(" ");
        let write = writable.then_some("W").unwrap_or(" ");
        let exec = executable.then_some("X").unwrap_or(" ");
    
        write!(f, "{} {} {}", read, write, exec)
    }
}

#[allow(unused)]
pub fn remap_test() {
    let mut kernel_space = KERNEL_SPACE.exclusive_access();
    let mid_text: VirtAddr = ((stext as usize + etext as usize) / 2).into();
    let mid_rodata: VirtAddr = ((srodata as usize + erodata as usize) / 2).into();
    let mid_data: VirtAddr = ((sdata as usize + edata as usize) / 2).into();
    assert!(!kernel_space
        .page_table
        .translate(mid_text.floor())
        .unwrap()
        .writable(),);
    assert!(!kernel_space
        .page_table
        .translate(mid_rodata.floor())
        .unwrap()
        .writable(),);
    assert!(!kernel_space
        .page_table
        .translate(mid_data.floor())
        .unwrap()
        .executable(),);
    println!("remap_test passed!");
}

pub struct MemoryMapArea {
    pub vpn_range: VPNRange,
    pub data_frames: BTreeMap<VirtPageNum, FrameTracker>,
    pub map_perm: MapPermission,
    pub fd: usize,
    pub offset: usize,
    pub flags: usize,
}

impl MemoryMapArea {
    pub fn new(
        start_va: VirtAddr,
        end_va: VirtAddr,
        map_perm: MapPermission,
        fd: usize,
        offset: usize,
        flags: usize,
    ) -> Self {
        let start_vpn: VirtPageNum = start_va.floor();
        let end_vpn: VirtPageNum = end_va.ceil();
        Self {
            vpn_range: VPNRange::new(start_vpn, end_vpn),
            data_frames: BTreeMap::new(),
            map_perm,
            fd,
            offset,
            flags,
        }
    }

    pub fn from_another(another: &MemoryMapArea) -> Self {
        Self {
            vpn_range: another.vpn_range.clone(),
            data_frames: BTreeMap::new(),
            map_perm: another.map_perm,
            fd: another.fd,
            offset: another.offset,
            flags: another.flags,
        }
    }
    
    /// 只分配内存, 不映射文件
    /// 一次只分配一页
    pub fn map_one(
        &mut self,
        page_table: &mut PageTable,
        vpn: VirtPageNum,
        // fd_table: Vec<Option<FileDescriptor>>,
    ) -> bool {
        // 分配物理页
        let frame = frame_alloc().unwrap();
        let ppn = frame.ppn;
        self.data_frames.insert(vpn, frame);
        let pte_flags = PTEFlags::from_bits(self.map_perm.bits).unwrap();
        page_table.map(vpn, ppn, pte_flags);
        println!("mmap vpn: {:#X} -> ppn: {:#X}, {:#}", vpn.0, ppn.0, self.map_perm);
        
        // // 复制文件数据到内存
        // if let Some(file_descriptor) = &fd_table[self.fd] {
        //     match file_descriptor {
        //         FileDescriptor::Regular(inode) => {
        //             if inode.readable() {
        //                 let va: usize = VirtAddr::from(vpn).into();
        //                 let mmap_base: usize = VirtAddr::from(self.vpn_range.get_start()).into();
        //                 let page_offset = va - mmap_base + self.offset;
        //                 let buf =
        //                     translated_byte_buffer(page_table.token(), va as *const u8, PAGE_SIZE);
        //                 inode.set_offset(page_offset);
        //                 inode.read(UserBuffer::new(buf));
        //             }
        //         }
        //         FileDescriptor::Abstract(_) => todo!(),
        //     };
        // }
        return true;
    }

    /// 为所有页面分配内存
    /// 不映射文件
    pub fn map(&mut self, page_table: &mut PageTable) {
        for vpn in self.vpn_range.into_iter() {
            self.map_one(page_table, vpn);
        }
    }
    
    pub fn unmap(&mut self, page_table: &mut PageTable) {
        for vpn in self.vpn_range {
            if self.data_frames.contains_key(&vpn) {
                self.data_frames.remove(&vpn);
                page_table.unmap(vpn);
            }
        }
    }
}

impl Display for MemoryMapArea {
    fn fmt(&self, f: &mut Formatter<'_>) -> core::fmt::Result {
        let start_virt_addr = VirtAddr::from(self.vpn_range.get_start());
        let end_virt_addr = VirtAddr::from(self.vpn_range.get_end());
        write!(
            f,
            "{:<#16x}  {:<#16x}   {:#}   fd: {}   FIXED: {}",
            start_virt_addr.0, end_virt_addr.0, self.map_perm, self.fd, self.flags & MAP_FIXED != 0
        )
    }
}

pub struct AuxHeader {
    pub _type: usize,
    pub value: usize,
}

impl AuxHeader {
    #[inline]
    pub fn new(_type: usize, value: usize) -> Self {
        Self { _type, value }
    }
}

impl Display for AuxHeader {
    fn fmt(&self, f: &mut Formatter<'_>) -> core::fmt::Result {
        write!(f, "AuxHeader type: {} value: {}", self._type, self.value)
    }
}
