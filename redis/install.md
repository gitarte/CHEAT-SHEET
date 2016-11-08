# INSTALL Redis 
### DEBIAN 8.x
```sh
TO DO...
```

### CENTOS 7.x
Well.. f**k SELInux! Type ```SELINUX=disabled``` in /etc/selinux/config and reboot...

Easy way:
```sh
$ wget -r --no-parent -A 'epel-release-*.rpm' http://dl.fedoraproject.org/pub/epel/7/x86_64/e/
$ rpm -Uvh dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-*.rpm
$ yum -y install redis
$ systemctl start redis.service
$ systemctl enable redis.service
```
Fun way :) :
```sh
$ yum -y groupinstall "Development Tools"
$ yum -y install kernel-devel
$ wget http://download.redis.io/releases/redis-3.2.5.tar.gz
$ tar xzf redis-3.2.5.tar.gz
$ cd redis-3.2.5/deps
$ make hiredis jemalloc linenoise lua geohash-int
$ cd ..
$ make && make install
$ cp redis.conf /etc/
$ cp sentinel.conf /etc/
```
