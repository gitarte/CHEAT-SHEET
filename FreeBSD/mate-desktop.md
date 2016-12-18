```sh
pkg install vim xf86-video-fbdev mate-desktop mate xorg slim bash-4.4
echo 'moused_enable="YES"' >> /etc/rc.conf
echo 'dbus_enable="YES"'   >> /etc/rc.conf
echo 'hald_enable="YES"'   >> /etc/rc.conf
echo 'slim_enable="YES"'   >> /etc/rc.conf
echo 'exec mate-session'   >> /home/artgaw/.xinitrc
chown artgaw:artgaw /home/artgaw/.xinitrc
chsh -s /usr/local/bin/bash artgaw
```
