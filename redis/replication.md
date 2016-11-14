# Redis REPLICATION
### Overview
This cheat sheet shows how to configure Redis's replication, where master node on host ```shared1``` has two exact copies on hosts ```shared2``` and ```shared3```. All machines are visible over network and their hostnames can be resolved to IP addresses thanks to ```/etc/hosts``` file.
### 1. Install Redis on each machine
Follow instructions in this link [install]
### 2. Create master node
On ```shared1``` edit ```/etc/redis/redis.conf``` and set or change entries sa follows:
```sh
tcp-keepalive 60
#bind 127.0.0.1
masterauth  stupidpassword3
requirepass stupidpassword3
maxmemory-policy noeviction
appendonly yes
appendfilename "appendonly.aof"
```
Restart Redis
```sh
$ systemctl restart redis.service
```
### 3. Create slave nodes
On ```shared1``` and ```shared2``` edit ```/etc/redis/redis.conf``` and set or change following entries:
```sh
#bind 127.0.0.1
masterauth stupidpassword3
requirepass stupidpassword3
slaveof shared1 6379
```
Restart Redis
```sh
$ systemctl restart redis.service
```


[install]: <https://github.com/gitarte/CHEAT-SHEET/blob/master/redis/install.md>
