fastestmirror=true
max_parallel_downloads=20
deltarpm=1
ip_resolve=4

&& sudo fwupdmgr get-devices \
&& sudo fwupdmgr refresh --force \
&& sudo fwupdmgr get-updates \
&& sudo fwupdmgr update \

&& sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
&& sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
&& sudo dnf -y upgrade --refresh \
&& sudo dnf -y check \
&& sudo dnf -y autoremove \
&& sudo dnf -y install tlp tlp-rdw \
&& sudo systemctl enable tlp \
&& sudo dnf -y install gnome-extensions-app gnome-tweaks gnome-shell-extension-window-list gnome-shell-extension-appindicator gnome-shell-extension-apps-menu gnome-shell-extension-dash-to-dock \
&& sudo dnf -y install curl cabextract xorg-x11-font-utils fontconfig \
&& sudo dnf -y groupupdate sound-and-video \
&& sudo dnf -y install gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg \
&& sudo dnf -y install lame\* --exclude=lame-devel \
&& sudo dnf -y group upgrade --with-optional Multimedia \
&& sudo dnf -y install vlc mplayer audacity \
&& sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc \
&& sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' \
&& sudo dnf -y check-update \
&& sudo dnf -y install code \
&& sudo dnf -y install gparted \
&& echo "all done"
