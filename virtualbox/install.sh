sudo apt -y remove virtualbox
sudo apt -y remove virtualbox-6.0
sudo apt -y autoremove
sudo apt -y clean
sudo apt -y autoclean

sudo apt -y install curl build-essential linux-headers-$(uname -r)

curl https://download.virtualbox.org/virtualbox/6.0.12/virtualbox-6.0_6.0.12-133076~Ubuntu~bionic_amd64.deb    -o virtualbox.deb
curl https://download.virtualbox.org/virtualbox/6.0.12/Oracle_VM_VirtualBox_Extension_Pack-6.0.12.vbox-extpack -o Oracle_VM_VirtualBox_Extension_Pack-6.0.12.vbox-extpack

sudo reboot 

sudo dpkg -i virtualbox.deb
sudo apt -y -f install

# in case of "There were problems setting up VirtualBox"
sudo -s
/sbin/vboxconfig
