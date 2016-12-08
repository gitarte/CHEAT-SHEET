# INSTALL Redis 
### DEBIAN 8.x
```sh
$ apt -y install build-essential tcl8.5 wget
$ wget http://download.redis.io/releases/redis-3.2.6.tar.gz
$ tar xvzf redis-3.2.5.tar.gz
$ cd redis-3.2.5/deps
$ make hiredis jemalloc linenoise lua geohash-int
$ cd ..
$ make && make install
$ mkdir /etc/redis
$ cp redis.conf /etc/redis/
$ cp sentinel.conf /etc/redis/
$ vim /etc/redis/redis.conf
supervised systemd
dir /var/lib/redis
logfile /var/log/redis/redis.log
$ tee /etc/systemd/system/redis.service <<-'EOF'
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=redis
Group=redis
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target
EOF
$ adduser redis
$ mkdir /var/lib/redis
$ mkdir /var/log/redis
$ chown -R redis:redis /var/lib/redis
$ chown -R redis:redis /var/log/redis
$ chown -R redis:redis /etc/redis
$ systemctl start redis.service
$ systemctl enable redis.service
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
$ yum -y install kernel-devel wget
$ wget http://download.redis.io/releases/redis-3.2.5.tar.gz
$ tar xvzf redis-3.2.5.tar.gz
$ cd redis-3.2.5/deps
$ make hiredis jemalloc linenoise lua geohash-int
$ cd ..
$ make && make install
$ mkdir /etc/redis
$ cp redis.conf /etc/redis/
$ cp sentinel.conf /etc/redis/
$ vim /etc/redis/redis.conf
supervised systemd
dir /var/lib/redis
logfile /var/log/redis/redis.log
$ tee /usr/lib/systemd/system/redis.service <<-'EOF'
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=redis
Group=redis
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target
EOF
$ adduser redis
$ mkdir /var/lib/redis
$ mkdir /var/log/redis
$ chown -R redis:redis /var/lib/redis
$ chown -R redis:redis /var/log/redis
$ chown -R redis:redis /etc/redis
$ systemctl start redis.service
$ systemctl enable redis.service
```
