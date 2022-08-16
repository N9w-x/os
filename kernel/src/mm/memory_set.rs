use alloc::collections::BTreeMap;
use alloc::sync::Arc;
use alloc::vec;
use alloc::vec::Vec;
use core::arch::asm;
use core::fmt::{Display, Formatter};

use lazy_static::*;
use riscv::register::satp;
use spin::Mutex;
use xmas_elf::ElfFile;

use crate::config::{
    AT_BASE, AT_CLKTCK, AT_EGID, AT_ENTRY, AT_EUID, AT_FLAGS, AT_GID, AT_HWCAP, AT_NOELF,
    AT_PAGESIZE, AT_PHDR, AT_PHENT, AT_PHNUM, AT_PLATFORM, AT_SECURE, AT_UID, CLOCK_FREQ,
    MAP_ANONYMOUS, MAP_FIXED, MEMORY_END, MMIO, PAGE_SIZE, SIGRETURN_TRAMPOLINE, TRAMPOLINE,
    KERNEL_MEMORY_MAP_BASE, MEMORY_MAP_BASE, USER_STACK_BASE,
};
use crate::fs::{File, FileDescriptor, FileType, open_file, OpenFlags};
use crate::mm::aux::AuxHeader;
use crate::mm::frame_allocator::FRAME_ALLOCATOR;
use crate::mm::mmap::MemoryMapArea;

use super::frame_allocator::{frame_add_ref, frame_get_ref};
use super::{frame_alloc, page_table, translated_byte_buffer, FrameTracker, UserBuffer};
use super::{PTEFlags, PageTable, PageTableEntry};
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
    pub static ref KERNEL_SPACE: Arc<Mutex<MemorySet>> =
        Arc::new(Mutex::new(MemorySet::new_kernel()) );
    pub static ref KERNEL_TOKEN: usize = KERNEL_SPACE.lock().token();
}

pub struct MemorySet {
    page_table: PageTable,
    areas: Vec<MapArea>,
    pub heap_base: VirtAddr,
    pub heap_end: VirtAddr,
    heap: BTreeMap<VirtPageNum, FrameTracker>, // user heap
    pub mmap_area_base: VirtAddr,
    pub mmap_area_end: VirtAddr,
    pub mmap_areas: Vec<MemoryMapArea>, // mmap
}

impl MemorySet {
    // pub fn set_mem_flags(&mut self, vpn: VirtPageNum, flags: usize) -> isize {
    //     const PROT_NONE: usize = 0;
    //     const PROT_READ: usize = 1;
    //     const PROT_WRITE: usize = 2;
    //     const PROT_EXEC: usize = 4;
        
    //     let pte_res = self.set_pte_flags(vpn, flags);
    //     let mut map_area_res = -1;
    //     for area in &mut self.areas {
    //         if area.vpn_range.contain(vpn) {
    //             let mut map_perm = MapPermission::U;
    //             if (flags & PROT_READ) != 0 {
    //                 map_perm |= MapPermission::R
    //             }
    //             if flags & PROT_WRITE != 0 {
    //                 map_perm |= MapPermission::W
    //             }
    //             if flags & PROT_EXEC != 0 {
    //                 map_perm |= MapPermission::X
    //             }
                
    //             area.map_perm = map_perm;
    //             break;
    //         }
    //     }
        
    //     if map_area_res == -1 || pte_res == -1 {
    //         -1
    //     } else {
    //         0
    //     }
    // }
    
    // fn set_pte_flags(&mut self, vpn: VirtPageNum, flags: usize) -> isize {
    //     self.page_table.set_pte_flags(vpn, flags)
    // }
    
    pub fn new_bare() -> Self {
        Self {
            page_table: PageTable::new(),
            areas: Vec::new(),
            heap_base: 0.into(),
            heap_end: 0.into(),
            heap: BTreeMap::new(),
            mmap_area_base: 0.into(),
            mmap_area_end: 0.into(),
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
        memory_set.mmap_area_base = KERNEL_MEMORY_MAP_BASE.into();
        memory_set.mmap_area_end = KERNEL_MEMORY_MAP_BASE.into();
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
    pub fn from_elf(elf_data: &[u8]) -> (Self, usize, usize, Vec<AuxHeader>) {
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

        memory_set.heap_base = user_heap_base.into();
        memory_set.heap_end = user_heap_base.into();
        memory_set.mmap_area_base = MEMORY_MAP_BASE.into();
        memory_set.mmap_area_end = MEMORY_MAP_BASE.into();

        (
            memory_set,
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
        // copy heap
        for (vpn, src_frame) in user_space.heap.iter() {
            let dst_frame = frame_alloc().unwrap();
            let dst_ppn = dst_frame.ppn;
            memory_set.heap.insert(*vpn, dst_frame);
            memory_set.page_table.map(*vpn, dst_ppn, PTEFlags::U | PTEFlags::R | PTEFlags::W);

            let src_ppn = src_frame.ppn;
            // copy data
            dst_ppn
                .get_bytes_array()
                .copy_from_slice(src_ppn.get_bytes_array());
        }
        // copy mmap
        for mmap_area in user_space.mmap_areas.iter() {
            let mut new_mmap_area = MemoryMapArea::from_another(mmap_area);
            for (vpn, frame_tracker) in mmap_area.data_frames.iter() {
                let src_ppn = frame_tracker.ppn;
                let frame = frame_alloc().unwrap();
                let dst_ppn = frame.ppn;
                dst_ppn
                    .get_bytes_array()
                    .copy_from_slice(src_ppn.get_bytes_array());
                new_mmap_area.data_frames.insert(*vpn, frame);
                memory_set.page_table.map(*vpn, dst_ppn, PTEFlags::from_bits(mmap_area.map_perm.bits() as u16).unwrap());
            }
            memory_set.mmap_areas.push(new_mmap_area);
        }
        memory_set.heap_base = user_space.heap_base;
        memory_set.heap_end = user_space.heap_end;
        memory_set.mmap_area_base = user_space.mmap_area_base;
        memory_set.mmap_area_end = user_space.mmap_area_end;
        memory_set
    }

    pub fn from_existed_user_cow(user_space: &mut MemorySet) -> MemorySet {
        let mut memory_set = Self::new_bare();
        // trampoline, trap context, user stack 不能 CoW
        // map trampoline
        memory_set.map_sigreturn_trampoline();
        memory_set.map_trampoline();
        for area in user_space.areas.iter() {
            // code segment, data segment 之后 CoW
            if VirtAddr::from(area.vpn_range.get_start()) < user_space.heap_base {
                continue;
            }
            // trap context, user stack
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

        // CoW: code segment, data segment, user heap, mmap
        let page_table = &mut user_space.page_table;
        for area in user_space.areas.iter() {
            // code segment, data segment
            if VirtAddr::from(area.vpn_range.get_start()) < user_space.heap_base {
                let mut new_area = MapArea::from_another(area);
                for vpn in area.vpn_range {
                    let pte = page_table.translate_mut_ref(vpn).unwrap();
                    let flags = pte.flags() & !PTEFlags::W | PTEFlags::COW;
                    let ppn = pte.ppn();
                    frame_add_ref(ppn);
                    pte.set_flags(flags);
                    memory_set.page_table.map(vpn, ppn, flags);
                    new_area.insert_cow(vpn, ppn);
                }
                memory_set.areas.push(new_area);
            }
        }

        // ! 因未知错误，heap/mmap暂时不CoW
        // heap
        // for (vpn, frame_tracker) in user_space.heap.iter() {
            // let pte = page_table.translate_mut_ref(*vpn).unwrap();
            // let flags = pte.flags() & !PTEFlags::W | PTEFlags::COW;
            // let ppn = pte.ppn();
            // assert_eq!(ppn, frame_tracker.ppn);
            // frame_add_ref(ppn);
            // pte.set_flags(flags);
            // memory_set.page_table.map(*vpn, ppn, flags);
            // memory_set.heap.insert(*vpn, FrameTracker { ppn });
        // }
        for (vpn, src_frame) in user_space.heap.iter() {
            let dst_frame = frame_alloc().unwrap();
            let dst_ppn = dst_frame.ppn;
            memory_set.heap.insert(*vpn, dst_frame);
            memory_set.page_table.map(*vpn, dst_ppn, PTEFlags::U | PTEFlags::R | PTEFlags::W);

            let src_ppn = src_frame.ppn;
            // copy data
            dst_ppn
                .get_bytes_array()
                .copy_from_slice(src_ppn.get_bytes_array());
        }
        memory_set.heap_base = user_space.heap_base;
        memory_set.heap_end = user_space.heap_end;
        // mmap
        for mmap_area in user_space.mmap_areas.iter() {
            // let mut child_mmap_area = MemoryMapArea::from_another(mmap_area);
            // for (vpn, frame_tracker) in mmap_area.data_frames.iter() {
            //     let pte = parent_page_table.translate_mut_ref(*vpn).unwrap();
            //     let flags = pte.flags() & !PTEFlags::W | PTEFlags::COW;
            //     let ppn = pte.ppn();
            //     assert_eq!(ppn, frame_tracker.ppn);
            //     pte.set_flags(flags);
            //     memory_set.page_table.map(*vpn, ppn, flags);
            //     child_mmap_area.data_frames.insert(vpn.clone(), FrameTracker { ppn });
            // }

            let mut new_mmap_area = MemoryMapArea::from_another(mmap_area);
            for (vpn, frame_tracker) in mmap_area.data_frames.iter() {
                let src_ppn = frame_tracker.ppn;
                let frame = frame_alloc().unwrap();
                let dst_ppn = frame.ppn;
                dst_ppn
                    .get_bytes_array()
                    .copy_from_slice(src_ppn.get_bytes_array());
                new_mmap_area.data_frames.insert(*vpn, frame);
                memory_set.page_table.map(*vpn, dst_ppn, PTEFlags::from_bits(mmap_area.map_perm.bits() as u16).unwrap());
            }
            memory_set.mmap_areas.push(new_mmap_area);
        }
        memory_set.mmap_area_base = user_space.mmap_area_base;
        memory_set.mmap_area_end = user_space.mmap_area_end;

        memory_set
    }

    pub fn cow_alloc(&mut self, vpn: VirtPageNum) {
        if let Some(pte) = self.page_table.translate_mut_ref(vpn) {
            let old_ppn = pte.ppn();
            let flags = pte.flags() & !PTEFlags::COW | PTEFlags::W;
            if frame_get_ref(old_ppn) == 1 {
                // Store Fault 处剩余引用计数 = 1，则将该页重新变为可写
                pte.set_flags(flags);
            } else {
                // 否则重新分配内存
                let frame = frame_alloc().unwrap();
                let new_ppn = frame.ppn;
                // 修改页表，建立映射
                *pte = PageTableEntry::new(new_ppn, flags);
                // 复制数据
                new_ppn.get_bytes_array().copy_from_slice(&old_ppn.get_bytes_array());
                for area in self.areas.iter_mut() {
                    if area.vpn_range.contain(vpn) {
                        // old_ppn 此时被remove和dealloc
                        area.data_frames.insert(vpn, frame);
                        break;
                    }
                }
            }
        } else {
            panic!("Page table entry doesn't exit.")
        }
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
        println!("this is mmap areas:");
        for area in &self.mmap_areas {
            println!("{:#}", area);
        }
    }
    
    pub fn insert_mmap_area(&mut self, mmap_area: MemoryMapArea) {
        self.mmap_areas.push(mmap_area);
    }

    pub fn insert_kmmap_area(
        &mut self,
        start_va: VirtAddr,
        end_va: VirtAddr,
        fd: isize,
        offset: usize,
        flags: usize,
        fd_table: &Vec<Option<FileDescriptor>>,
    ) {
        let mut kmmap_area = MemoryMapArea::new(
            start_va,
            end_va,
            MapPermission::W | MapPermission::R,
            fd,
            offset,
            flags,
        );
        kmmap_area.map(&mut self.page_table, fd_table);
        self.mmap_areas.push(kmmap_area);
    }

    pub fn remove_kmmap_area(&mut self, start_vpn: VirtPageNum) -> bool {
        self.remove_mmap_area(start_vpn)
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
        fd_table: &Vec<Option<FileDescriptor>>,
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
            return area.map_one(&mut self.page_table, vpn, fd_table);
            // return area.map_one(&mut self.page_table, vpn);
        }
        false
    }
    
    /// 为所有页面分配内存并映射文件
    pub fn alloc_mmap_area(&mut self, va: VirtAddr, fd_table: &Vec<Option<FileDescriptor>>) {
        let vpn: VirtPageNum = va.floor();
        if let Some(area) = self
            .mmap_areas
            .iter_mut()
            .find(|area| area.vpn_range.contain(vpn))
        {
            // return area.map_one(&mut self.page_table, vpn, fd_table);
            area.map(&mut self.page_table, fd_table);
        }
    }
    
    pub fn set_pte_flags(&self, vpn: VirtPageNum, flags: PTEFlags) -> bool {
        self.page_table.set_pte_flags(vpn, flags)
    }
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
    // 记录映射关系，但不分配内存
    pub fn insert_cow(&mut self, vpn: VirtPageNum, ppn: PhysPageNum) {
        self.data_frames.insert(vpn, FrameTracker { ppn });
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
        let pte_flags = PTEFlags::from_bits(self.map_perm.bits as u16).unwrap();
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
    let mut kernel_space = KERNEL_SPACE.lock();
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
