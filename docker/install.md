# INSTALL DOCKER 
### UBUNTU 16.04
```sh
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt-get -y update
apt-get -y install docker-engine
systemctl enable docker
usermod -aG docker artgaw
```
### DEBIAN 8.x
```sh
$ #to install
$ apt-get update
$ apt-get -y upgrade
$ apt-get -y install apt-transport-https ca-certificates
$ apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
$ echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> /etc/apt/sources.list
$ apt-get update
$ apt-get -y install docker-engine
$ systemctl enable docker.service
$ systemctl start docker
$ adduser -g docker docker
$
$ #to verify
$ su - docker
$ docker images
```

### CENTOS 7.x
```sh
$ #to install
$ tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
$ yum -y install docker-engine
$ systemctl enable docker.service
$ systemctl start docker
$ adduser -g docker docker
$
$ #to verify
$ su - docker
$ docker images
```
