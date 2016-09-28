# INSTALL DOCKER 
### ON DEBIAN 8.x
```sh
$ apt-get update
$ apt-get -y upgrade
$ apt-get -y install apt-transport-https ca-certificates
$ apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
$ echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> /etc/apt/sources.list
$ apt-get update
$ apt-get -y install docker-engine
```

### COMMON STUFF: Allow access without sudo/root
```sh
$ gpasswd -a ${USER} docker
$ service docker restart
```
