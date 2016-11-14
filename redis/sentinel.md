# Redis SENTINEL
### Overview
This cheat sheet shows how to configure Redis's sentinel. Machines ```shared1```, ```shared2``` and ```shared3``` are visible over network and their hostnames can be resolved to IP addresses thanks to ```/etc/hosts``` file. Visit [howto] for more details.
### 1. Install Redis on each machine
Follow instructions in this [install] link.
### 2. Join machines with replication mode
Follow instructions in this [replication] link.
### 3. Create sentinel's configuration file
On each machine execute following command (don't change the host name):
```sh
$ tee /etc/redis/sentinel.conf <<-'EOF'
port 26379
protected-mode no
dir /tmp
logfile /var/log/redis/sentinel.log
sentinel monitor                 myRedisMaster shared1 6379 2
sentinel auth-pass               myRedisMaster stupidpassword3
sentinel down-after-milliseconds myRedisMaster 5000
sentinel failover-timeout        myRedisMaster 10000
sentinel parallel-syncs          myRedisMaster 1
EOF
```
### 4. Create sentinel's startup script
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
### 5. Check if it's working
```sh
$ ps ax | grep redis
  725 ?        Ssl    0:04 /usr/local/bin/redis-server *:6379
 2296 ?        Ssl    0:04 /usr/local/bin/redis-server *:26380
```
[install]: <https://github.com/gitarte/CHEAT-SHEET/blob/master/redis/install.md>
[replication]: <https://github.com/gitarte/CHEAT-SHEET/blob/master/redis/replication.md>
[howto]: <http://redis.io/topics/sentinel>
