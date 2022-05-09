mkfs.vfat -n "test" -F 32 -C fat32.img 40960
sudo mount -o loop vfat fat32.img mount
sudo cp -r ../fat32-fuse/sd_mnt2/* ./mount
sudo cp -r ../user/target/riscv64gc-unknown-none-elf/release/* ./mount
