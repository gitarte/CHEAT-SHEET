# MongoDB REPLICA SET
### Overview
This cheat sheet shows how to configure Samba to serve GlusterFS storage. Machines ```shared1```, ```shared2``` and ```shared3``` are visible over network and their hostnames can be resolved to IP addresses thanks to ```/etc/hosts``` file.
### 1. Install Samba and set GlusterFS cluster on each machine
Follow instructions in this link [samba] and this link [gluster]
### 2. Configure Samba
Assumming that each GlusterFS cluster shares ```/mnt/appdata/``` direcory on each machine execute:
```sh
$ mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
$ tee /etc/samba/smb.conf <<-'EOF'
[global]
workgroup = WORKGROUP
map to guest = bad user

[gluster]
path      = /mnt/appdata
valid users = @smbgrp
guest ok = no
writable = yes
browsable = yes
EOF
$ groupadd smbgrp
$ useradd mysamba -G smbgrp
$ smbpasswd -a  mysamba
$ chown mysamba:mysamba /mnt/appdata/
$ service smb restart
```
### 3. Test results
Go to some host and exec following
```sh
$ yum -y install cifs-utils
$ mkdir -p /gluster/res1
$ mkdir -p /gluster/res2
$ mkdir -p /gluster/res3
$ mount -t cifs //shared1/gluster /gluster/res1 -o rw,user=mysamba
$ mount -t cifs //shared2/gluster /gluster/res2 -o rw,user=mysamba
$ mount -t cifs //shared2/gluster /gluster/res2 -o rw,user=mysamba
```
Manipulation of the content of any ```/gluster/resX``` should take results in each other as well as on each```sharedX``` in ```/mnt/appdata``` 
[gluster]: <https://github.com/gitarte/CHEAT-SHEET/blob/master/glusterfs/cluster.md>
[samba]: <https://github.com/gitarte/CHEAT-SHEET/blob/master/samba/install.mb>
