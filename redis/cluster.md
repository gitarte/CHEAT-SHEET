# Redis CLUSTER
### Overview
This cheat sheet shows how to configure Redis's cluster. Machines ```shared1```, ```shared2``` and ```shared3``` are visible over network and their hostnames can be resolved to IP addresses thanks to ```/etc/hosts``` file.
### 1. Install Redis on each machine
Follow instructions in this link [install]
### 2. Create master node
On ```shared1``` edit ```/etc/redis.conf``` and set or change following entries:
```sh
tcp-keepalive 60
#bind 127.0.0.1
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
On ```shared1``` and ```shared2``` edit ```/etc/redis.conf``` and set or change following entries:
```sh
#bind 127.0.0.1
requirepass stupidpassword3
slaveof shared1 6379
masterauth stupidpassword3
```
Restart Redis
```sh
$ systemctl restart redis.service
```


[install]: <https://github.com/gitarte/CHEAT-SHEET/blob/master/redis/install.md>