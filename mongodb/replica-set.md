# MongoDB REPLICA SET
### Overview
This cheat sheet shows how to configure MongoDB's replica set. Machines ```shared1```, ```shared2``` and ```shared3``` are visible over network and their hostnames can be resolved to IP addresses thanks to ```/etc/hosts``` file.
### 1. Install MongoDB on each machine
Follow instructions in this link [install]
### 2. Give a name to each MongoDB installation and set the path to auth key
On each machine edit ```/etc/init.d/mongod``` file and replace 
```sh
OPTIONS=" -f $CONFIGFILE"
``` 
with 

```sh
OPTIONS=" -f $CONFIGFILE --keyFile '/var/lib/mongo/certs/replicakey' --replSet 'rSetPoc'"
``` 
where ```rSetPoc``` is the actual name of replica set. Then exec
```sh
$ systemctl daemon-reload
```

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
### 4. Make MongoDB listening on all addresses
On each machine comment out line beginining with ```bindIp``` in ```/etc/mongod.conf``` then restart mongo
```sh
$ service mongod restart
```

### 5. Initiate the replica set
On ```shared1``` connect to mongo shell and execute
```javascript
rs.initiate(
  {
    _id : "rSetPoc",
    members: [
      { _id : 0, host : "shared1:27017" },
      { _id : 1, host : "shared2:27017" },
      { _id : 2, host : "shared3:27017" }
    ]
  }
)
```
### 6. Create user with privileges to create other users
Connect to the mongo shell that at te moment is voted to be PRIMARY. Then execute:
```javascript
admin = db.getSiblingDB("admin")
admin.createUser(
  {
    user: "rsadmin",
    pwd: "stupidpasswd",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)
```
### 7. Create cluster admin
Connect to the mongo shell that at te moment is voted to be PRIMARY. Then execute:
```javascript
db.getSiblingDB("admin").auth("rsadmin", "stupidpasswd" )
db.getSiblingDB("admin").createUser(
  {
    "user" : "clusteradmin",
    "pwd" : "stupidpasswd2",
    roles: [ { "role" : "clusterAdmin", "db" : "admin" } ]
  }
)
```
### 8. Create app user
Connect to the mongo shell that at te moment is voted to be PRIMARY. Then execute:
```javascript
db.getSiblingDB("admin").auth("rsadmin", "stupidpasswd" )
db.getSiblingDB("admin").createUser(
  {
    "user" : "apudUser",
    "pwd" : "apudPass",
    roles: [ { "role" : "readWrite", "db" : "apud" } ]
  }
)
```
[install]: <https://github.com/gitarte/CHEAT-SHEET/blob/master/mongodb/install.md>
