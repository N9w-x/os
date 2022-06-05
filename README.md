### OsKernel22-untitled OS

#### 运行

> make all

在根目录下只有大赛要求的make all 指令用以生成内核二进制文件

在kernel目录下提供两种不同的运行方式

> make run RUNMODE=autotest

autotest模式会在内核启动之后自动运行初赛的测试用例

不添加RUNMODE属性,则会启动命令行,可以接受用户的命令输入

> make img-lite

将sdcard_file目录下文件打包并在kernel目录下生成fat32格式的文件镜像fat32.img

(叫lite是因为只会将文件打包,并不会对用户程序的源文件重新编译,这样减少了编译时间(还有一个原因是直接使用初赛编译好的测例也不用重新编译))

> make gdb server

会编译内核并使用qemu的远程debug模式,等待gdb连接

> make gdb client

会尝试连接到qemu,对内核进行调试

#### 感谢与声明

本项目不同程度的借鉴了[rcore-tutorial-v3](https://github.com/rcore-os/rCore-Tutorial-v3)和[ultraos](https://gitlab.eduxiji.net/ultrateam/ultraos)两个项目,并在它们的工作上加以改进

同时感谢大赛群里的各位大佬的热心帮助