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
  && yum -y install vlc mplayer\
  && echo "all done"
```
