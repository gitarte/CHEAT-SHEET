### write zeros to free space of vm disk

install zerofree
```
apt install zerofree
```

reboot the vm an enter recovery mode, select root shell and run
```
zerofree -v /dev/sda1
halt
```
### Compact the VDI file
unattach te disk from vm (in VirtualBox window) and do:
```
cd VirtualBox\ VMs/hilodeb/ 
VBoxManage modifymedium disk ./hilodeb_*.vdi --compact
```
