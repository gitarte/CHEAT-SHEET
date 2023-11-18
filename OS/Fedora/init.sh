echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
echo "fastestmirror=True"        >> /etc/dnf/dnf.conf
echo "deltarpm=1"                >> /etc/dnf/dnf.conf
echo "ip_resolve=4"              >> /etc/dnf/dnf.conf

&& sudo dnf -y update \
&& sudo dnf -y upgrade \
&& sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
&& sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
&& sudo dnf -y upgrade --refresh \
&& sudo dnf -y groupupdate core \
&& sudo dnf -y check \
&& sudo dnf -y autoremove \
&& sudo fwupdmgr get-devices \
&& sudo fwupdmgr refresh --force \
&& sudo fwupdmgr get-updates \
&& sudo fwupdmgr update \
&& sudo dnf -y groupupdate sound-and-video \
&& sudo dnf -y install lame\* --exclude=lame-devel \
&& sudo dnf -y install tlp tlp-rdw && sudo systemctl enable tlp \
&& sudo dnf -y install vim vlc gimp gnome-tweaks unzip p7zip p7zip-plugins unrar vlc mplayer audacity gparted \
&& sudo dnf -y install kernel-devel.x86_64 qt5-qttools-devel.x86_64 qt5-qttools-libs-help.x86_64 libvpx7.x86_64 \
&& sudo dnf -y install dnf-plugins-core \
&& sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo \
&& sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc \
&& sudo dnf -y install brave-browser \
&& echo "all done"
