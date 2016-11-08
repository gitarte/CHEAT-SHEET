# MongoDB REPLICA SET
### Overview
This cheat sheet shows how to configure MongoDB's replica set. The machines are visible over network and their hostnames can be resolved to IP addresses thanks to ```/etc/hosts``` file.

### 1. Install MongoDB on each machine
Follow instructions in this link [install]

### 2. Give a name to each MongoDB installation
```shared1``` = ```rs1```

```shared2``` = ```rs2```

```shared3``` = ```rs3```

On each machine edit ```/etc/init.d/mongod``` file and replace 

```OPTIONS=" -f $CONFIGFILE"``` 

with 

```OPTIONS=" -f $CONFIGFILE -replSet 'rsX'"``` 

changing X to specific replica set number.

### 3. Make replica auth key
On each machine exec
```sh
$ mkdir /var/lib/mongo/certs
$ chown mongod:mongod /var/lib/mongo/certs
```
On ```shared1``` which suppose to be a PRIMARY member exec:
```sh
$ cd /var/lib/mongo/certs/
$ openssl rand -base64 755 > replicakey
$ chmod 400 replicakey
$ chown mongod:mongod replicakey
$ scp replicakey root@shared2:/var/lib/mongo/certs/
$ scp replicakey root@shared3:/var/lib/mongo/certs/
```

### 4. Initiate the replica set
On ```shared1``` connect to mongo shell and execute rs.initiate()
```sh
$ mongo
> rs.initiate()
```
### Add ```shared2``` and ```shared3``` to the replica set
```sh
rs.add("shared2")
rs.add("shared3")
```
[install]: <https://github.com/gitarte/CHEAT-SHEET/blob/master/mongodb/install.md>
