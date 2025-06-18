```bash
sudo apt update && sudo apt upgrade
sudo apt install -y qemu-kvm libvirt-daemon-system virtinst libvirt-clients bridge-utils
sudo systemctl enable libvirtd
sudo systemctl start  libvirtd
sudo systemctl status libvirtd
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
sudo apt install virt-manager
```
