```bash
dpkg --add-architecture i386 \
  && apt -y update && apt -y upgrade \
  && apt -y install build-essential dkms cmake cmake-qt-gui tcl scons \
  && apt -y install linux-headers-`uname -r` net-tools \
  && apt -y install libminizip1 libappindicator3-0.1-cil libappindicator3-0.1-cil-dev libqt5opengl5 libqt5printsupport5 \
  && apt -y install openssl libssl-dev pkg-config \
  && apt -y install python3-pip \
  && apt -y install git apt-transport-https curl vim \
  && apt -y install traceroute screen gparted openssh-* \
  && apt -y install wine wine32 wine64 wine-binfmt q4wine \
  && apt -y install vlc audacity audacity-data silan vamp-plugin-sdk \
  && apt -y install tlp && systemctl enable tlp \
  && apt -y install ttf-mscorefonts-installer rar unrar \
  && apt -y install libavcodec-extra libavcodec-extra58 gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi \
  && apt -y install intel-microcode printer-driver-* \
  && apt -y install vim \
  && touch /home/artgaw/.vimrc \
  && chown artgaw:artgaw /home/artgaw/.vimrc \
  && echo 'source $VIMRUNTIME/defaults.vim' >> /home/artgaw/.vimrc \
  && echo 'set mouse-=a' >> /home/artgaw/.vimrc \
  && apt -y autoremove && apt -y clean && apt -y autoclean \
  && echo "ALL DONE"
```
