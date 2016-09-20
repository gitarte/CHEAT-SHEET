# DOCKER-SWARM
This cheat-sheet presents task to be done while creating and managing basic docker-swarm cluster.
### Cluster topology
Create as many machines as you wish. Each has to have working operating system and docker engine.
```
SwarmManager: 192.168.43.100 Debian + docker-engine
SwarmNode1:   192.168.43.101 Debian + docker-engine
SwarmNode2:   192.168.43.102 Debian + docker-engine
SwarmNode3:   192.168.43.103 Debian + docker-engine
```
### Create swarm manager
Login to SwarmManager machine.
```sh
$ # install and configure consul:
$ docker run --restart=always -d -p 8500:8500 -h consul consul -server -bootstrap
$ # install and configure swarm:
$ docker run --restart=always -d -p 3375:2375 swarm manage consul://192.168.43.100:8500
```
### Create swarm nodes
Following commands can be executed on each node respectively. In this example however we stay lagged into SwarmManager and execute all of them from this single machine.
```sh
$ docker -H=tcp://192.168.43.101:2375 run -d swarm join --advertise=192.168.43.101:2375 consul://192.168.43.100:8500
$ docker -H=tcp://192.168.43.102:2375 run -d swarm join --advertise=192.168.43.102:2375 consul://192.168.43.100:8500
$ docker -H=tcp://192.168.43.103:2375 run -d swarm join --advertise=192.168.43.103:2375 consul://192.168.43.100:8500
```
