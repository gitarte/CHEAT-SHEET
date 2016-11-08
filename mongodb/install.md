# INSTALL MongoDB 
### DEBIAN 8.x
```sh
TO DO...
```

### CENTOS 7.x
Well.. f**k SELInux! Type ```SELINUX=disabled``` in /etc/selinux/config and reboot...
```sh
$ tee /etc/yum.repos.d/mongodb-org-3.2.repo <<-'EOF'
[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc
EOF
$ yum -y install mongodb-org
$ service mongod start
$ adduser mongo -g mongod
```
