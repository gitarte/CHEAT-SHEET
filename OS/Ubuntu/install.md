```bash
#!/bin/bash
set -x \
  && apt-get -y install build-essential cmake tcl scons \
  && apt-get -y install linux-headers-`uname -r` \
  && apt-get -y install libindicator7 libappindicator1 \
  && apt-get -y install openssl libssl-dev pkg-config \
  && apt-get -y install python-pip python3-pip python-dev python3-dev \
  && pip  install --upgrade pip \
  && pip3 install --upgrade pip \
  && pip  install flake8 \
  && pip3 install flake8 \
  && pip  install flake8-docstrings \
  && pip3 install flake8-docstrings \
  && apt-get -y install git \
  && apt-get -y install qemu qemu-kvm virt-manager \
  && apt-get -y install traceroute screen gparted openssh-* \
  && apt-get -y install unrar wine winetricks q4wine wine-mono0.0.8 \
  && apt-get -y install vlc qnapi audacity audacity-data silan vamp-plugin-sdk \
  && apt-get -y install unity-tweak-tool \
  && dpkg -i /home/artgaw/Downloads/atom-amd64.deb \
  && apm install linter-flake8 \
  && apm install autocomplete-python \
  && apm install linter-jshint \
  && echo "ALL DONE"


#apt-get -y install libboost-all-dev
#apt-get -y install libncurses5-dev libcurl3-dev libvorbis-dev libspeex-dev libiksemel-dev libxml2-dev libtiff-tools
#apt-get -y install libpq-dev
#apt-get -y install python-tk python3-tk
#apt-get -y install python3-gi python3-gi-cairo python3-gi-dbg python-psycopg2
#apt-get -y install python-pygame
##apt-get -y install python-pyalsa python-alsaaudio
#apt-get -y install bluez bluez-tools bluetooth libbluetooth-dev
#pip  install PyBluez
#pip3 install PyBluez
#pip  install pep8
#pip3 install pep8
#apt-get -y install geany
#apt-get -y install codeblocks codeblocks-common codeblocks-contrib codeblocks-contrib-dbg codeblocks-dbg codeblocks-dev
#apt-get -y install pgadmin3 pgadmin3-data
#apt-get -y install virtualbox virtualbox-guest-additions-iso
#apt-get -y install rdate
#apt-get -y install minicom
```
