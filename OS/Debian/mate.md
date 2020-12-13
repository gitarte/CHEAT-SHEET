```bash
echo "START" \
&& apt -y update \
&& apt -y upgrade \
&& apt -y install linux-headers-`uname -r` net-tools \
&& apt -y install build-essential dkms cmake cmake-qt-gui tcl scons \
&& apt -y install openssl libssl-dev pkg-config ccrypt net-tools \
&& apt -y install libindicator7 libappindicator1 \
&& apt -y install python3-pip \
&& apt -y install git apt-transport-https curl vim \
&& apt -y install wine64 winetricks q4wine \
&& apt -y install vlc audacity audacity-data silan vamp-plugin-sdk \
&& apt -y install tlp && systemctl enable tlp \
&& apt -y install ttf-mscorefonts-installer rar unrar libavcodec-extra libavcodec-extra58 gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi \
&& apt -y install intel-microcode printer-driver-all \
&& echo "ALL DONE"
```
