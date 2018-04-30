```bash
#!/bin/bash
set -x \
  && apt -y install build-essential cmake tcl scons \
  && apt -y install linux-headers-`uname -r` \
  && apt -y install libindicator7 libappindicator1 \
  && apt -y install openssl libssl-dev pkg-config \
  && apt -y install libpango1.0-0 libpangox-1.0-0 python-gobject-2 python-gtk2 \
  && apt -y install python-testresources python3-testresources python-pip python3-pip python-dev python3-dev \
  && apt -y install python3-venv \
  && pip  install --upgrade pip \
  && pip3 install --upgrade pip \
  && pip  install flake8 \
  && pip3 install flake8 \
  && pip  install flake8-docstrings \
  && pip3 install flake8-docstrings \
  && apt -y install git \
  && apt -y install qemu qemu-kvm virt-manager \
  && apt -y install traceroute screen gparted openssh-* \
  && apt -y install unrar wine64 winetricks q4wine \
  && apt -y install vlc qnapi audacity audacity-data silan vamp-plugin-sdk \
  && apt -y install vim geany \
  && apt -y install gnome-tweak-tool \
  && echo "ALL DONE"

# xhost +si:localuser:root
#dpkg -i /home/artgaw/Downloads/atom-amd64.deb \
#apm install linter-flake8 \
#apm install autocomplete-python \
#apm install linter-jshint \
#apt -y install libboost-all-dev
#apt -y install libncurses5-dev libcurl3-dev libvorbis-dev libspeex-dev libiksemel-dev libxml2-dev libtiff-tools
#apt -y install libpq-dev
#apt -y install python-tk python3-tk
#apt -y install python3-gi python3-gi-cairo python3-gi-dbg python-psycopg2
#apt -y install python-pygame
##apt -y install python-pyalsa python-alsaaudio
#apt -y install bluez bluez-tools bluetooth libbluetooth-dev
#pip  install PyBluez
#pip3 install PyBluez
#pip  install pep8
#pip3 install pep8
#apt -y install geany
#apt -y install codeblocks codeblocks-common codeblocks-contrib codeblocks-contrib-dbg codeblocks-dbg codeblocks-dev
#apt -y install pgadmin3 pgadmin3-data
#apt -y install virtualbox virtualbox-guest-additions-iso
#apt -y install rdate
#apt -y install minicom
```
