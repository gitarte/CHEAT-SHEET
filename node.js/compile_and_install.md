# COMPILE AND INSTALL Node.js 
### DEBIAN 8.x
```sh
$ apt-get -y install build-essential 
$ apt-get -y install linux-headers-`uname -r`
$ # The rest is pretty much the same procedure as for CentOS
```
### CENTOS 7.x
First visit Node.js [home page] and choose version to be download. I preffer LTS which at the moment is v6.9.1. 
Copy the download link of source code. In my case it is [this]
```sh
$ yum -y groupinstall "Development Tools"
$ yum -y install kernel-devel
$ # mind the version you download
$ wget https://nodejs.org/dist/v6.9.1/node-v6.9.1.tar.gz
$ tar xvzf node-v6.9.1.tar.gz
$ cd node-v6.9.1
$ ./configure
$ make
$ # ...
$ # coffee break ;)
$ # ...
$ make test
$ # ...
$ # small coffee break ;)
$ # ...
$ make install
```
[home page]: <https://nodejs.org/en/download/>
[this]: <https://nodejs.org/dist/v6.9.1/node-v6.9.1.tar.gz>
