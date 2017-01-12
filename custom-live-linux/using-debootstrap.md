### Prepare your host
Mandatory:
```sh
apt-get -y update
apt-get -y install build-essential sbuild gawk bc
apt-get -y install syslinux isolinux xorriso genisoimage
apt-get -y install debootstrap cdebootstrap cdebootstrap-static
apt-get -y install squashfs-tools memtest86+ rsync
```
Optional but usefull:
```sh
apt-get -y install qemu qemu-kvm
apt-get -y install openssl openssl-blacklist openssl-blacklist-extra
apt-get -y install net-tools
apt-get -y install wget curl
apt-get -y install zip unzip
apt-get -y install vim
```
### Debootstrap your favorite Debian version (or deriverative)
```sh
# src: http://ftp.us.debian.org/debian/
# dst: ./chroot directory 
# ver: 64bit Debian 8.6 (jessie) minimal
debootstrap --arch=amd64 --variant=minbase jessie chroot http://ftp.us.debian.org/debian/ && \
mount -o bind /dev chroot/dev && \
cp /etc/resolv.conf chroot/etc/resolv.conf
```

### Do whatever you need inside debootstraped distro
Chroot into debootstraped distro:
```sh
chroot ./chroot
```
Modify the distro according to your demands:
```sh
mount none -t proc /proc && \
mount none -t sysfs /sys && \
mount none -t devpts /dev/pts && \
export HOME=/root && \
export LC_ALL=C && \
apt-get update && \
apt-get install dialog dbus --yes --force-yes && \
dbus-uuidgen > /var/lib/dbus/machine-id && \
echo "debian-live" > /etc/hostname && \
apt-get -y install linux-image-3.16.0-4-amd64 linux-headers-3.16.0-4-amd64 live-boot && \
passwd root  && \
# =======================================
# Optional: do your stuff here
# Each step outside this box is mandatory
# =======================================
rm -f /var/lib/dbus/machine-id && \
apt-get clean && \
rm -rf /tmp/* && \
rm /etc/resolv.conf && \
umount -lf /proc && \
umount -lf /sys && \
umount -lf /dev/pts && \
```
Leave chroot environment:
```sh
exit
```
### Build the ISO file
Prepare space for bootloader and ISO file:
```sh
umount -lf chroot/dev
mkdir -p image/{live,isolinux}
mksquashfs chroot image/live/filesystem.squashfs -e boot
```
Copy bootloader files. Mind the kernel version here:
```sh
cp chroot/boot/vmlinuz-3.16.0-4-amd64    image/live/vmlinuz1 && \
cp chroot/boot/initrd.img-3.16.0-4-amd64 image/live/initrd1 && \
cp /usr/lib/syslinux/isolinux.bin        image/isolinux/ && \
cp /usr/lib/syslinux/modules/bios/*      image/isolinux/ && \
cp /usr/share/misc/pci.ids               image/isolinux/ && \
cp /boot/memtest86+.bin                  image/live/memtest && \
```
Configure the bootloader:
```sh
tee image/isolinux/isolinux.cfg <<-'EOF'
UI menu.c32
prompt 0
menu title Debian Live
timeout 300
label Debian Live 3.16.0-4-amd64
menu label ^Debian Live 3.16.0-4-amd64
menu default
kernel /live/vmlinuz1
append initrd=/live/initrd1 boot=live
label hdt
menu label ^Hardware Detection Tool (HDT)
kernel hdt.c32
text help
HDT displays low-level information about the systems hardware.
endtext
label memtest86+
menu label ^Memory Failure Detection (memtest86+)
kernel /live/memtest
EOF
```
Finally build the ISO:
```sh
cd image && \
genisoimage \
        -rational-rock \
        -volid "Debian Live" \
        -cache-inodes \
        -joliet \
        -full-iso9660-filenames \
        -b isolinux/isolinux.bin \
        -c isolinux/boot.cat \
        -no-emul-boot \
        -boot-load-size 4 \
        -boot-info-table \
        -output ../debian-live.iso . 
```
### Enjoy the results
```sh
qemu-system-x86_64 -m 1024M -cdrom debian-live.iso 
```
