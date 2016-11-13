# Redis SENTINEL
### Overview
This cheat sheet shows how to configure Redis's sentinel. Machines ```shared1```, ```shared2``` and ```shared3``` are visible over network and their hostnames can be resolved to IP addresses thanks to ```/etc/hosts``` file. Visit [howto] for more details.
### 1. Install Redis on each machine
Follow instructions in this [install] link.
### 2. Create sentinel's configuration file
On each machine edit ```/etc/redis/sentinel.conf``` and set following entries (don't change the host name):
```sh
port 16379
sentinel monitor                 myRedisCluster shared1 6379 2
sentinel auth-pass               myRedisCluster stupidpassword3
sentinel down-after-milliseconds myRedisCluster 5000
sentinel failover-timeout        myRedisCluster 10000
sentinel parallel-syncs          myRedisCluster 1
logfile /var/log/redis/sentinel.log
dir /tmp
```
### 2. Create sentinel's startup script
On each machine:
```sh
$ tee /usr/lib/systemd/system/sentinel.service <<-'EOF'
[Unit]
Description=Redis persistent key-value database
After=network.target

[Service]
ExecStart=/usr/local/bin/redis-server /etc/redis/sentinel.conf --sentinel
ExecStop=/usr/bin/redis-shutdown
User=redis
Group=redis

[Install]
WantedBy=multi-user.target
EOF
$ systemctl daemon-reload
$ systemctl start sentinel.service
$ systemctl enable sentinel.service
```
### 3. Check if it's working
```sh
$ ps ax | grep redis
  725 ?        Ssl    0:04 /usr/local/bin/redis-server *:6379
 2296 ?        Ssl    0:04 /usr/local/bin/redis-server *:16380
```
[install]: <https://github.com/gitarte/CHEAT-SHEET/blob/master/redis/install.md>
[howto]: <http://redis.io/topics/sentinel>
