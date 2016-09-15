# DOCKER REGISTRY
### Overview
This cheat sheet shows how to start docker registry on Red Hat 7 with specyfic location of images
- [install docker] - How to install Docker on Red Hat 7
- [docker hub] - Docker registry in Docker Hub
- [know-how] - Docker registry know-how

### 1. Instal docker, create dir's, add user and so on...
```sh
yum --nogpgcheck install docker-engine.x86_64 docker-engine-selinux.noarch
adduser docreg
passwd docreg
usermod -aG docker docreg
mkdir -p /app/docker/cert
mkdir -p /app/docker/images
```
### 2. Get TLS certificates. Donn't forget about CA
```sh
/usr/bin/openssl genrsa -des3 2048 > /app/docker/cert/server.key
/usr/bin/openssl req -new -key /app/docker/cert/server.key -out /app/docker/cert/server.csr
```
### 3. Ensure ownership of dir's and files
```sh
chown -R docreg:docker /app/docker
```
### 4. Edit /etc/systemd/system/multi-user.target.wants/docker.service
```
ExecStart=/usr/bin/dockerd -g /app/docker/images
```
### 5. Ensure daemon stuff
```sh
systemctl daemon-reload
systemctl enable docker
service docker restart
```
### 6. Run registry container
```sh
/usr/bin/docker run \
  -d -p 5000:5000 --restart=always --name registry \
  -v /app/docker/cert:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/app/docker/cert/server.crt \
  -e REGISTRY_HTTP_TLS_KEY=/app/docker/cert/server.key \
  registry:2
```
[docker hub]: <https://hub.docker.com/_/registry/>
[know-how]: <https://docs.docker.com/registry/deploying/>
[install docker]: <https://docs.docker.com/engine/installation/linux/rhel/>
