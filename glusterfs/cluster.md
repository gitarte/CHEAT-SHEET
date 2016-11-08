# CREATE CLUSTER FOR GLUSTERFS 
### DEBIAN 8.x
```sh
TO DO...
```

### CENTOS 7.x
```sh
$ #to install
$ yum -y install centos-release-gluster epel-release
$ yum -y install glusterfs-server
$ systemctl enable glusterd
$ systemctl start glusterd
$ # on shared1
$ gluster peer probe shared2
$ gluster peer probe shared3

$ # to verify on shared1
$ gluster peer status
Number of Peers: 2
Hostname: shared3
Uuid: e4c0a9aa-e392-4de1-abb3-c1484f701c9f
State: Peer in Cluster (Connected)
Hostname: shared2
Uuid: dc695edf-5736-4420-9d09-b98a53ff59dc
State: Peer in Cluster (Connected)

$ # to verify on shared2
$ gluster peer status
Number of Peers: 2
Hostname: shared3
Uuid: e4c0a9aa-e392-4de1-abb3-c1484f701c9f
State: Peer in Cluster (Connected)
Hostname: shared1
Uuid: f4bbfb69-55fc-4675-8874-045b90cc3818
State: Peer in Cluster (Connected)

$ # to verify on shared3
$ gluster peer status
Number of Peers: 2
Hostname: shared2
Uuid: dc695edf-5736-4420-9d09-b98a53ff59dc
State: Peer in Cluster (Connected)
Hostname: shared1
Uuid: f4bbfb69-55fc-4675-8874-045b90cc3818
State: Peer in Cluster (Connected)

$ # on each volume (shared1, shared2 and shared3) execute
$ mkdir -p /data/gv0
$ # go to the volume, that you wish to be a master and execute
$ gluster volume create gv0 replica 3 shared1:/data/gv0 shared2:/data/gv0 shared3:/data/gv0 force
$ gluster volume start gv0
$ # on each volume (shared1, shared2 and shared3) execute following command
$ # replace sharedX with proper host name
$ mkdir /mnt/appdata
$ echo "sharedX:/gv0 /mnt/appdata glusterfs defaults,_netdev 0 0" | sudo tee -a /etc/fstab
$ mount /mnt/appdata

$ # to verify
[root@shared1 ~]# cd /mnt/appdata/
[root@shared1 appdata]# touch dupa

[root@shared2 ~]# ls /mnt/appdata/
dupa

[root@shared3 ~]# ls /mnt/appdata/
dupa
```
