```sh
$ apt-get -y install cifs-utils
$ yum -y install cifs-utils
mount -t cifs [//server_address/resource_name] [/path/to/local/mount/point] -o rw,user=[samba_user]
```
