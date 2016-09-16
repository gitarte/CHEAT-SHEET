# DOCKER OFFLINE CLIENT AND REGISTRY
### Overview
This cheat sheet shows how to
* 1. Extract image as a file to move it aroung 
* 2. Load extracted image into docker
* 3. Push an image into private registry
### 1. Backup to tarball
```sh
docker save imageName > imageName.tar
```
### 2. Load from tarball
```sh
docker load < imageName.tar
```
### 3. Tag an image as remote registry and push it
```sh
docker tag imageName registry_fqdn:5000/imageName
docker push registry_fqdn:5000/imageName
```
