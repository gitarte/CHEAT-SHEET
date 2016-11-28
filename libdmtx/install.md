# INSTALL libmdtx AND mdtx-utils 
### DEBIAN 8.x
```sh
TO DO...
```

### CENTOS 7.x
Build dependencies and requirements:
```sh
$ yum -y groupinstall "Development Tools"
$ yum -y install kernel-devel
$ yum -y install ImageMagick-c++ ImageMagick-c++-devel
$ yum -y install git
```
Obtaining sources:
```sh
$ git clone git://libdmtx.git.sourceforge.net/gitroot/libdmtx/libdmtx
$ git clone git://libdmtx.git.sourceforge.net/gitroot/libdmtx/dmtx-utils
```
Building libdmtx:
```sh
$ cd libdmtx
$ ./autogen.sh
$ ./configure
$ make
$ make install
```
Building dmtx-utils:
```sh
$ cd dmtx-utils
$ ./autogen.sh
$ export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/
$ ./configure
$ make
$ make install
```
Verify:
```sh
$ echo "dupa" | dmtxwrite | dmtxread 
dupa
```
