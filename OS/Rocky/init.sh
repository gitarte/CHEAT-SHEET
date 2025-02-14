echo "START" \
&& sudo echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf \
&& sudo echo "fastestmirror=True"        | sudo tee -a /etc/dnf/dnf.conf \
&& sudo echo "deltarpm=1"                | sudo tee -a /etc/dnf/dnf.conf \
&& sudo echo "ip_resolve=4"              | sudo tee -a /etc/dnf/dnf.conf \
&& sudo fwupdmgr get-devices \
&& sudo fwupdmgr refresh --force \
&& sudo fwupdmgr get-updates \
&& sudo fwupdmgr update \

&& sudo dnf -y update \
&& sudo dnf -y upgrade \
&& sudo dnf -y install dnf-plugins-core \
&& sudo dnf config-manager --set-enabled crb \
&& sudo dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm \
&& sudo dnf -y install https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-$(rpm -E %rhel).noarch.rpm \
&& sudo dnf -y install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm \
&& sudo dnf -y install --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm \
&& sudo dnf -y upgrade --refresh \
&& sudo dnf -y groupupdate core \
&& sudo dnf -y check \
&& sudo dnf -y autoremove \

&& sudo dnf -y groupupdate sound-and-video \
&& sudo dnf -y install lame\* --exclude=lame-devel \
&& sudo dnf -y install tlp tlp-rdw && sudo systemctl enable tlp \
&& sudo dnf -y install vim vlc gimp gnome-tweaks unzip p7zip p7zip-plugins unrar vlc mplayer audacity gparted \
&& sudo dnf -y install kernel-devel.x86_64 qt5-qttools-devel.x86_64 qt5-qttools-libs-help.x86_64 libvpx.x86_64 \
&& sudo dnf -y install podman \
&& curl -fsS https://dl.brave.com/install.sh | sh \
&& echo "all done"
