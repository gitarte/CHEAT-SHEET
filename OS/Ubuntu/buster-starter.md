```bash
apt -y update \
  && apt -y install build-essential cmake tcl scons \
  && apt -y install linux-headers-`uname -r` \
  && apt -y install libindicator7 libappindicator1 \
  && apt -y install openssl libssl-dev pkg-config \
  && apt -y install git curl \
  && apt -y install traceroute screen gparted openssh-* \
  && apt -y install unrar wine64 winetricks q4wine \
  && apt -y install vlc qnapi audacity audacity-data silan vamp-plugin-sdk \
  && apt -y install gnome-shell-extension-top-icons-plus \
  && apt -y ttf-mscorefonts-installer \
  && echo "ALL DONE"
```