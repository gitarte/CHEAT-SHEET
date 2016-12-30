# DOCKER REGISTRY
### Overview
This cheat sheet shows how to start docker registry on Red Hat 7 with specyfic location of images
- [install] - How to install Docker on Red Hat 7
- [docker hub] - Docker registry in Docker Hub
- [know-how] - Docker registry's know-how

### 1. Get TLS certificates
If you can achieve properly signed certificate:
```sh
$ mkdir /var/lib/docker/certs
$ cd /var/lib/docker/certs
$ # generate key (-des3 for passphrase)
$ openssl genrsa 2048 > server.key
$ # generate signing request (CN must be a FQDN of your server)
$ openssl req -new -key server.key -out server.csr
```
You may sign the certificate by yourself using following command, but then you have to copy ```server.crt``` file to ```/etc/docker/certs.d/MGR_FQDN:5000/ca.crt``` for every client daemon
```sh
$ openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```
### 2. Run registry container
```sh
$ docker run \
  -d -p 5000:5000 --restart=always --name registry \
  -v /var/lib/docker/certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/server.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/server.key \
  registry:latest
```
### 3. Using the registry
```sh
$ docker tag image_name MGR_FQDN:5000/organisation_name/image_name
$ docker push MGR_FQDN:5000/organisation_name/image_name
$ docker pull MGR_FQDN:5000/organisation_name/image_name
```

### 4. List content of the registry
```sh
$ curl --cacert /var/lib/docker/certs/server.crt -X GET https://MGR_FQDN:5000/v2/_catalog
```
[docker hub]: <https://hub.docker.com/_/registry/>
[know-how]: <https://docs.docker.com/registry/deploying/>
[install]: <https://github.com/gitarte/CHEAT-SHEET/blob/master/docker/install.md>
