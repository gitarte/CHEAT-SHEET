# INSTALL OrientDB 
### DEBIAN 8.x
```sh
TO DO...
```

### CENTOS 7.x
Easy way (preferred):
```sh
$ wget https://orientdb.com/download.php?file=orientdb-community-2.2.0.tar.gz
$ tar xvzr orientdb-community-2.2.0.tar.gz
$ mv orientdb-community-2.2.0 /opt/orientdb
```
Fun way:
```sh
$ yum -y groupinstall "Development Tools"
$ yum -y install kernel-devel
$ yum -y install git
$ git clone https://github.com/orientechnologies/orientdb
$ git checkout develop
$ cd orientdb
$ mvn clean install
```
Common stuff (do this no matter if you choose easy or fun way):
```sh
$ tee /etc/systemd/system/orientdb.service <<-'EOF'
[Unit]
Description=OrientDB Server
After=network.target
After=syslog.target

[Install]
WantedBy=multi-user.target

[Service]
User=orientdb
Group=orientdb
ExecStart=/opt/orientdb/bin/server.sh
EOF
$ adduser orientdb
$ passwd orientdb
$ chown -R orientdb:orientdb /opt/orientdb
$ systemctl daemon-reload
$ systemctl start  orientdb.service
$ systemctl enable orientdb.service
```
