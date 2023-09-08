fastestmirror=true
max_parallel_downloads=20
deltarpm=1
ip_resolve=4

sudo fwupdmgr get-devices \
&& sudo fwupdmgr refresh --force \
&& sudo fwupdmgr get-updates \
&& sudo fwupdmgr update


sudo dnf -y install dnf-plugins-core \
&& sudo dnf -y install epel-release \
&& sudo dnf install --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm \
&& sudo dnf install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm \
&& sudo dnf -y upgrade --refresh \
&& sudo dnf -y check \
&& sudo dnf -y autoremove \
&& sudo dnf -y install tlp tlp-rdw \
&& sudo systemctl enable tlp \
&& sudo dnf -y install gnome-tweaks gnome-shell-extension-window-list gnome-shell-extension-appindicator gnome-shell-extension-apps-menu gnome-shell-extension-dash-to-dock \
&& sudo dnf -y install curl cabextract fontconfig \
&& sudo dnf -y groupupdate sound-and-video \
&& sudo dnf -y install gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel \
&& sudo dnf -y install lame\* --exclude=lame-devel \
&& sudo dnf -y group upgrade --with-optional Multimedia \
&& sudo dnf -y install vlc audacity \
&& sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc \
&& sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' \
&& sudo dnf -y check-update \
&& sudo dnf -y install code \
&& sudo dnf -y install gparted \
&& sudo dnf -y install snapd && sudo systemctl enable snapd && sudo systemctl start snapd && sudo snap install discord opera \
&& sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ \
&& sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc \
&& sudo dnf -y install brave-browser \
&& sudo dnf -y install qemu-kvm qemu-img libvirt virt-manager virt-install virt-viewer libvirt-client && sudo systemctl start libvirtd &&  sudo systemctl enable libvirtd \
&& echo "all done"
