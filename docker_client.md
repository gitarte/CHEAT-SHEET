# DOCKER OFFLINE CLIENT
### Overview
This cheat sheet shows how to load images from tarballs and push'em to local registry.
- [install docker] - How to install Docker on Red Hat 7

### 1. Instal docker, create dirs, add user and so on...
```sh
yum --nogpgcheck install docker-engine.x86_64 docker-engine-selinux.noarch
adduser docreg
passwd docreg
usermod -aG docker docreg
mkdir -p /app/docker/images
chown -R docreg:docker /app/docker
```
### 2. Edit /etc/systemd/system/multi-user.target.wants/docker.service to set custom dir for images
```
ExecStart=/usr/bin/dockerd -g /app/docker/images
```
### 3. Take care of daemon's stuff
```sh
systemctl daemon-reload
systemctl enable docker
service docker restart
```
### 4. Backup an image somewhere
```sh
docker save debian > debian.tar
```
### 5. Load some images from tarballs
```sh
# load
docker load < debian.tar
# verify
docker images
```
Sample result:
```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
debian              latest              031143c1c662        2 weeks ago         125.1 MB
```

[install docker]: <https://docs.docker.com/engine/installation/linux/rhel/>
