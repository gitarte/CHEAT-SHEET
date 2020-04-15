```bash
apt -y update \
  && apt -y upgrade \
  && apt -y install build-essential dkms cmake cmake-qt-gui tcl scons \
  && apt -y install linux-headers-`uname -r` net-tools \
  && apt -y install libindicator7 libappindicator1 \
  && apt -y install openssl libssl-dev pkg-config \
  && apt -y install python-pip python3-pip \
  && apt -y install git apt-transport-https curl vim \
  && apt -y install traceroute screen gparted openssh-* \
  && apt -y install wine64 winetricks q4wine \
  && apt -y install vlc audacity audacity-data silan vamp-plugin-sdk \
  && apt -y install ttf-mscorefonts-installer rar unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi \
  && apt -y install gnome-shell-extension-dashtodock gnome-shell-extension-top-icons-plus gnome-shell-extension-desktop-icons \
  && apt -y install firmware-linux firmware-linux-nonfree intel-microcode printer-driver-* firmware-iwlwifi \
  && modprobe iwlwifi \
  && curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - \
  && echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list \
  && apt update \
  && apt -y install brave-browser \
  && echo "ALL DONE"

```
