```bash
#!/bin/bash
set -x \
  && yum -y install kernel-devel kernel-headers \
  && yum -y install epel-release \
  && yum -y localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm \
  && yum -y install yum-utils lshw \
  && yum -y install geany \
  && yum -y install redhat-lsb libXScrnSaver \
  && yum -y install python2-pip python34-pip python-devel \
  && yum -y install gstreamer{,1}-plugins-ugly gstreamer-plugins-bad-nonfree gstreamer1-plugins-bad-freeworld \
  && yum -y install vlc mplayer audacity \
  && rpm -ivh /home/artgaw/Downloads/google-chrome-stable_current_x86_64.rpm \
  && echo "all done"
```
