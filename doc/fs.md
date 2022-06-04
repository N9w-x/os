
# sd卡磁盘结构

默认sd卡磁盘的物理数据布局如下

![这里写图片描述](https://img-blog.csdn.net/20170308200924298?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDY1MDg0NQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### MBR(Main Boot Recorder)

448个字节,计算机启动后首先将这个部分的代码载入内存并执行,通常用来解释分区结构

在主引导扇区后有四个DPT(disk partition table 硬盘分区表)

每个DPT都会指向该硬盘分区的扩展分区表(EBR),扩展分区表中会记录该分区中硬盘数据的具体信息

因为我们的系统只有一个分区,所以只需要读取第一个分区的分区表数据就行了

以第一个DPT为例,DPT的16字节中存储了以下数据

![这里写图片描述](https://img-blog.csdn.net/20170308201308112?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDY1MDg0NQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

我们的文件系统中主要关注的是0x1c6字节处的分区开始扇区号,它指向该分区的扩展记录表的扇区号,通过它访问fat32文件系统(但是事实上评测机的sd卡没有分区表,直接读EBR就好了)

# fat32

FAT32 将一个卷分为三个区域

- Reserved Region
- The File Allocation Table(FAT)
- The directory and  data area
- ![image-20220111204306102](pic.asset/image-20220111204306102.png)

### Boot Sector and BPB

Boot Record 占用每个卷保留区域( Reserved Region)的**0号扇区** 或者叫boot sector

位于boot 扇区的 BPB 必须包含所有的BPB区域位置,以确认FAT卷能够支持的最大容量

> The BPB in the boot sector of a FAT volume must always have all of the BPB fields for either the FAT12/FAT16 or FAT32 BPB type. This ensures maximum compatibility of the FAT volume and will also ensure that all FAT file system drivers understand and support the volume correctly. 

为了保证数据不会丢失,在sector 6 必须放置一个备份的BPB

#### BPB and BS

| offset(decl) | offset(hex) | size(bytes) | meaning                                                      |
| ------------ | ----------- | ----------- | ------------------------------------------------------------ |
| 0            | 0x00        | 3           | jump over the bpb and ebp                                    |
| 3            | 0x03        | 8           | OEM identifier                                               |
| 11           | 0x0b        | 2           | the number of bytes per cluster                              |
| 13           | 0x0d        | 1           | number of sectors per cluster                                |
| 14           | 0x0e        | 2           | number of reserved sectors. the boot record include          |
| 16           | 0x10        | 1           | number of fat on the storage media.ofen 2                    |
| 17           | 0x11        | 2           | number of directory entries (must be set so that the root directory occupies entire sectors). |
| 19           | 0x13        | 2           | the total sectors in the logical volume.if value is 0,more than 65535 sectors in volume .actual count stoted in Large Sector Count entry  at **0x20** |
| 24           | 0x18        | 2           | number of sectors per track                                  |
| 26           | 0x1a        | 2           | number of heads or sides on the storage media                |
| 28           | 0x1c        | 4           | numbers of hidden sectors                                    |
| 32           | 0x20        | 4           | large sector count this field                                |

#### Extended Boot Record

| offset(decl) | offset(hex) | size(bytes) | meaning |
| ------------ | ----------- | ----------- | ------- |
| 36           | 0x24        | 1           |         |

### 通常所在区块

| sector id | 内容                            |
| --------- | ------------------------------- |
| 0         | BS(boot sector) 包含BPB         |
| 1         | FSinfo 包含FAT32 卷一些基本信息 |
| 6         | BS bak                          |
| 7         | FSInfo bak                      |

## FAT表

fat系列的文件系统都是用类似鱼链表的方式串联起来的,文件的扇区使用情况通过fat表记录

fat32中每个表项占32个字节,表项中的数据表示终结或者指向当前文件占用的下个扇区号

## short entry

8.3 format

- 8个字节的基本名
- 3个字节扩展名
- 文件名在存储时转换为大写
- 允许没有基本名
- 不能使用特殊字符 包括(0x22,0x2a,0x2b,0x2c,0x2e,0x2f,0x3a,0x3b,0x3c,0x3d,0x3e,0x3f,0x5b,0x5c,0x5d,0x7c)

tips

> 1. 使用0x20填充尾随空间
> 2. dir_name[0] 0xe5表示 该direntry 可用
> 3. 0x00同样表示 dirent 可用 ,同时也表示尾随的direntry 全部可用
> 4. dir_name[0] 不能 等于 0x20 (以空格开头)

每个目录项都必须有两个目录 `.` `..`,指向父目录和本身(除了根目录)

空文件目录项中的first cluster 字段为0

## long entry

- 长目录项是通过一系列额外的目录项实现的

- long dir entry 必须置于短文件目录项之前,并与之相邻

- 最后一个long entry order = order | 0x40

对长名称对应的短名称计算校验和,并置于每个长名称目录下



![image-20220115222345634](pic.asset/image-20220115222345634.png)

# 文件缓存

文件系统以块(扇区)为单位进行读写,为了提高磁盘IO的性能,我们参考ultraOS的做法,在文件系统和磁盘数据之间添加了一层缓存层作为代理,以块为单位对磁盘数据进行缓存.读写会优先在缓存中进行查询,如果cache miss了,再从磁盘中实际读取数据。

```rust
pub struct BlockCache {
    pub cache: [u8; BLOCK_SZ],
    block_id: usize,
    block_device: Arc<dyn BlockDevice>,
    modified: bool,
}
```

使用RAII的思想，将缓存块的生命周期和磁盘数据绑定，当缓存块从内存中被销毁的时候，检查当前块是否修改过，如果修改过就将当前块写回到磁盘中

```rust
    fn drop(&mut self) {
        if self.modified {
            self.block_device.write_block(self.block_id, &self.cache)
        }
    }
```

创建一个计数器对文件缓存的命中率进行测试，在cache访问的入口函数中对访问次数和命中次数进行计数，统计缓存的访问次数和命中次数，最后在系统shutdown的时候输出结果

```rust
pub struct CacheHitCounter {
    hit_times: usize,
    access_times: usize,
}

impl CacheHitCounter {
    pub fn add_hit(&mut self) {
        self.hit_times += 1;
    }
    
    pub fn add_access(&mut self) {
        self.access_times += 1;
    }
}
```

初步记录的缓存命中情况如下，命中率约为0.62（在运行测试用例这种线性执行的运行环境下,每个文件都只会访问一次,所有的cache hit完全来自于单个文件内部的重复访问,在这样的前提下,缓存命中率能够达到0.62比较令我惊讶了）

![image-20220530135326107](pic.asset/hit_rate_old.png)





我们的fat32文件系统目前使用的是ultraos的simple_fat32文件系统,并在他们的基础上进行改动和优化,simple_fat32文件系统在打开文件时,仅仅返回一个包含文件信息的inode节点,并没有实际将文件内容从磁盘中载入内存，lazy的做法确实能够减少内存开销和磁盘IO的开销，但是按照局部性原理的思想，打开的文件更有可能在未来被访问，所以我们做了一个简单的prefetch,以试图提高缓存的命中率,在打开文件时,将指定数量的文件扇区(当前是5个,如果文件扇区数量少于5就所有扇区)加载到cacheManager中,试图提高缓存的命中率

添加prefetch之后的结果数据表明,缓存命中率确实提高了1个百分点(这不就是没提高吗),可能是因为只在打开文件时预加载区块,文件中反复访问的扇区和文件的头几个扇区没有必然关系。同时还发现，添加了prefetch之后，对缓存块的访问次数增加了，推测的原因为添加了prefetch之后，缓存更容易发生换出，所以访问次数也随之增加了。

文件系统以块(扇区)为单位进行读写,为了提高磁盘IO的性能,我们参考ultraOS的做法,在文件系统和磁盘数据之间添加了一层缓存层作为代理,以块为单位对磁盘数据进行缓存.读写会优先在缓存中进行查询,如果cache miss了,再从磁盘中实际读取数据。

```rust
pub struct BlockCache {
    pub cache: [u8; BLOCK_SZ],
    block_id: usize,
    block_device: Arc<dyn BlockDevice>,
    modified: bool,
}
```

使用RAII的思想，将缓存块的生命周期和磁盘数据绑定，当缓存块从内存中被销毁的时候，检查当前块是否修改过，如果修改过就将当前块写回到磁盘中

```rust
    fn drop(&mut self) {
        if self.modified {
            self.block_device.write_block(self.block_id, &self.cache)
        }
    }
```

创建一个计数器对文件缓存的命中率进行测试，在cache访问的入口函数中对访问次数和命中次数进行计数，统计缓存的访问次数和命中次数，最后在系统shutdown的时候输出结果

```rust
pub struct CacheHitCounter {
    hit_times: usize,
    access_times: usize,
}

impl CacheHitCounter {
    pub fn add_hit(&mut self) {
        self.hit_times += 1;
    }
    
    pub fn add_access(&mut self) {
        self.access_times += 1;
    }
}
```

初步记录的缓存命中情况如下，命中率约为0.62（在运行测试用例这种线性执行的运行环境下,每个文件都只会访问一次,所有的cache hit完全来自于单个文件内部的重复访问,在这样的前提下,缓存命中率能够达到0.62比较令我惊讶了）

![image-20220530135326107](pic.asset/hit_rate_old.png)





我们的fat32文件系统目前使用的是ultraos的simple_fat32文件系统,并在他们的基础上进行改动和优化,simple_fat32文件系统在打开文件时,仅仅返回一个包含文件信息的inode节点,并没有实际将文件内容从磁盘中载入内存，lazy的做法确实能够减少内存开销和磁盘IO的开销，但是按照局部性原理的思想，打开的文件更有可能在未来被访问，所以我们做了一个简单的prefetch,以试图提高缓存的命中率,在打开文件时,将指定数量的文件扇区(当前是5个,如果文件扇区数量少于5就所有扇区)加载到cacheManager中,试图提高缓存的命中率

添加prefetch之后的结果数据表明,缓存命中率确实提高了1个百分点(这不就是没提高吗),可能是因为只在打开文件时预加载区块,文件中反复访问的扇区和文件的头几个扇区没有必然关系。同时还发现，添加了prefetch之后，对缓存块的访问次数增加了，推测的原因为添加了prefetch之后，缓存更容易发生换出，所以访问次数也随之增加了。

文件系统以块(扇区)为单位进行读写,为了提高磁盘IO的性能,我们参考ultraOS的做法,在文件系统和磁盘数据之间添加了一层缓存层作为代理,以块为单位对磁盘数据进行缓存.读写会优先在缓存中进行查询,如果cache miss了,再从磁盘中实际读取数据。

```rust
pub struct BlockCache {
    pub cache: [u8; BLOCK_SZ],
    block_id: usize,
    block_device: Arc<dyn BlockDevice>,
    modified: bool,
}
```

使用RAII的思想，将缓存块的生命周期和磁盘数据绑定，当缓存块从内存中被销毁的时候，检查当前块是否修改过，如果修改过就将当前块写回到磁盘中

```rust
    fn drop(&mut self) {
        if self.modified {
            self.block_device.write_block(self.block_id, &self.cache)
        }
    }
```

创建一个计数器对文件缓存的命中率进行测试，在cache访问的入口函数中对访问次数和命中次数进行计数，统计缓存的访问次数和命中次数，最后在系统shutdown的时候输出结果

```rust
pub struct CacheHitCounter {
    hit_times: usize,
    access_times: usize,
}

impl CacheHitCounter {
    pub fn add_hit(&mut self) {
        self.hit_times += 1;
    }
    
    pub fn add_access(&mut self) {
        self.access_times += 1;
    }
}
```

初步记录的缓存命中情况如下，命中率约为0.62（在运行测试用例这种线性执行的运行环境下,每个文件都只会访问一次,所有的cache hit完全来自于单个文件内部的重复访问,在这样的前提下,缓存命中率能够达到0.62比较令我惊讶了）

![image-20220530135326107](pic.asset/hit_rate_old.png)





我们的fat32文件系统目前使用的是ultraos的simple_fat32文件系统,并在他们的基础上进行改动和优化,simple_fat32文件系统在打开文件时,仅仅返回一个包含文件信息的inode节点,并没有实际将文件内容从磁盘中载入内存，lazy的做法确实能够减少内存开销和磁盘IO的开销，但是按照局部性原理的思想，打开的文件更有可能在未来被访问，所以我们做了一个简单的prefetch,以试图提高缓存的命中率,在打开文件时,将指定数量的文件扇区(当前是5个,如果文件扇区数量少于5就所有扇区)加载到cacheManager中,试图提高缓存的命中率

添加prefetch之后的结果数据表明,缓存命中率确实提高了1个百分点(这不就是没提高吗),可能是因为只在打开文件时预加载区块,文件中反复访问的扇区和文件的头几个扇区没有必然关系。同时还发现，添加了prefetch之后，对缓存块的访问次数增加了，推测的原因为添加了prefetch之后，缓存更容易发生换出，所以访问次数也随之增加了。

文件系统以块(扇区)为单位进行读写,为了提高磁盘IO的性能,我们参考ultraOS的做法,在文件系统和磁盘数据之间添加了一层缓存层作为代理,以块为单位对磁盘数据进行缓存.读写会优先在缓存中进行查询,如果cache miss了,再从磁盘中实际读取数据。

```rust
pub struct BlockCache {
    pub cache: [u8; BLOCK_SZ],
    block_id: usize,
    block_device: Arc<dyn BlockDevice>,
    modified: bool,
}
```

使用RAII的思想，将缓存块的生命周期和磁盘数据绑定，当缓存块从内存中被销毁的时候，检查当前块是否修改过，如果修改过就将当前块写回到磁盘中

```rust
    fn drop(&mut self) {
        if self.modified {
            self.block_device.write_block(self.block_id, &self.cache)
        }
    }
```

创建一个计数器对文件缓存的命中率进行测试，在cache访问的入口函数中对访问次数和命中次数进行计数，统计缓存的访问次数和命中次数，最后在系统shutdown的时候输出结果

```rust
pub struct CacheHitCounter {
    hit_times: usize,
    access_times: usize,
}

impl CacheHitCounter {
    pub fn add_hit(&mut self) {
        self.hit_times += 1;
    }
    
    pub fn add_access(&mut self) {
        self.access_times += 1;
    }
}
```

初步记录的缓存命中情况如下，命中率约为0.62（在运行测试用例这种线性执行的运行环境下,每个文件都只会访问一次,所有的cache hit完全来自于单个文件内部的重复访问,在这样的前提下,缓存命中率能够达到0.62比较令我惊讶了）

![image-20220530135326107](pic.asset/hit_rate_old.png)





我们的fat32文件系统目前使用的是ultraos的simple_fat32文件系统,并在他们的基础上进行改动和优化,simple_fat32文件系统在打开文件时,仅仅返回一个包含文件信息的inode节点,并没有实际将文件内容从磁盘中载入内存，lazy的做法确实能够减少内存开销和磁盘IO的开销，但是按照局部性原理的思想，打开的文件更有可能在未来被访问，所以我们做了一个简单的prefetch,以试图提高缓存的命中率,在打开文件时,将指定数量的文件扇区(当前是5个,如果文件扇区数量少于5就所有扇区)加载到cacheManager中,试图提高缓存的命中率

添加prefetch之后的结果数据表明,缓存命中率确实提高了1个百分点(这不就是没提高吗),可能是因为只在打开文件时预加载区块,文件中反复访问的扇区和文件的头几个扇区没有必然关系。同时还发现，添加了prefetch之后，对缓存块的访问次数增加了，推测的原因为添加了prefetch之后，缓存更容易发生换出，所以访问次数也随之增加了。

