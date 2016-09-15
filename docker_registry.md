# DOCKER REGISTRY
### Overview
This cheat sheet shows how to start docker registry on Red Hat 7 with specyfic location of images
- [install docker] - How to install Docker on Red Hat 7
- [docker hub] - Docker registry in Docker Hub
- [know-how] - Docker registry's know-how

### 1. Instal docker, create dirs, add user and so on...
```sh
yum --nogpgcheck install docker-engine.x86_64 docker-engine-selinux.noarch
adduser docreg
passwd docreg
usermod -aG docker docreg
mkdir -p /app/docker/certs
mkdir -p /app/docker/registry
mkdir -p /app/docker/images
```
### 2. Get TLS certificates
Proper signeed certificate
```sh
cd /app/docker/certs
# generate key (without -des3 for no pass phrase)
openssl genrsa -des3 2048 > server.key
# generate signing request (CN must be a FQDN of your server)
openssl req -new -key server.key -out server.csr
```
You may sign the certificate by yourself using following command, but then you have to copy server.crt file to /etc/docker/certs.d/YOUR_FQDN:5000/ca.crt for every deamon
```sh
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```
### 3. Ensure ownership of dirs and files
```sh
chown -R docreg:docker /app/docker
```
### 4. Edit ```/etc/systemd/system/multi-user.target.wants/docker.service```
```
ExecStart=/usr/bin/dockerd -g /app/docker/images
```
### 5. Take care of daemon's stuff
```sh
systemctl daemon-reload
systemctl enable docker
service docker restart
```
### 6. Run registry container
```sh
docker run \
  -d -p 5000:5000 --restart=always --name registry \
  -v /app/docker/certs:/certs \
  -e STORAGE_PATH=/app/docker/registry \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/app/docker/cert/server.crt \
  -e REGISTRY_HTTP_TLS_KEY=/app/docker/cert/server.key \
  registry:2
```
[docker hub]: <https://hub.docker.com/_/registry/>
[know-how]: <https://docs.docker.com/registry/deploying/>
[install docker]: <https://docs.docker.com/engine/installation/linux/rhel/>
