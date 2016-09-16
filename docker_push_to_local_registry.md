# DOCKER OFFLINE CLIENT AND REGISTRY
### Overview
This cheat sheet shows how to deal with docker in separate network environment.
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
