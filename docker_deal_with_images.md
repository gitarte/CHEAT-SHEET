# DOCKER OFFLINE CLIENT AND REGISTRY
### Overview
This cheat sheet shows how to:
* 1. Plain stuff
* 2. Extract image in a portable form
* 3. Load extracted image back into docker
* 4. Push an image into private registry

### 1. Listing, removing
```sh
$ docker images
REPOSITORY                  TAG         IMAGE ID          CREATED           SIZE
registry_fqdn:5000/debian   latest      031143c1c662      2 weeks ago       125.1 MB

$ docker rmi registry_fqdn:5000/debian
Untagged: registry_fqdn:5000/debian:latest
Untagged: registry_fqdn:5000/debian@sha256:aab4571d32a9ecd5b4b25e3a4843773be32c78d5fd09aa10a1db97b8511e89de
Deleted: sha256:031143c1c662878cf5be0099ff759dd219f907a22113eb60241251d29344bb96
Deleted: sha256:9e63c5bce4585dd7038d830a1f1f4e44cb1a1515b00e620ac718e934b484c938
```
### 2. Backup to tarball
```sh
$ docker save imageName > imageName.tar
```
### 3. Load from tarball
```sh
$ docker load < imageName.tar
```
### 4. Tag an image as remote registry and push it
```sh
$ docker tag imageName registry_fqdn:5000/imageName
$ docker push registry_fqdn:5000/imageName
```
Mind the constraints while using self signed certificate
