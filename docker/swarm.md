# DOCKER-SWARM
This cheat-sheet presents task to be done while creating and managing basic docker-swarm cluster.
### The infrastructure
Prepare some hosts and optionally manage their hostnames
```
SwarmManager	192.168.1.100
SwarmNode1		192.168.1.101
SwarmNode2		192.168.1.102
SwarmNode3		192.168.1.103
```
Ensure they see each other over IP network and following ports are opened:
```
TCP         port 2377 for cluster management communications
TCP and UDP port 7946 for communication among nodes
TCP and UDP port 4789 for overlay network traffic
```

Install docker-engine on each of them:

I do recommend:
* https://docs.docker.com/engine/installation/linux/debian
* https://docs.docker.com/engine/installation/linux/ubuntulinux

I don't recommend (learn about Docker vs. Device Mapper):
* https://docs.docker.com/engine/installation/linux/centos
* https://docs.docker.com/engine/installation/linux/rhel

Ensure to install version >= 1.12.x
```sh
dkr@Swarm[manager or node]:~$ docker version 
Client:
 Version:      1.12.1
 API version:  1.24
 Go version:   go1.6.3
 Git commit:   23cf638
 Built:        Thu Aug 18 05:02:53 2016
 OS/Arch:      linux/amd64

Server:
 Version:      1.12.1
 API version:  1.24
 Go version:   go1.6.3
 Git commit:   23cf638
 Built:        Thu Aug 18 05:02:53 2016
 OS/Arch:      linux/amd64
 ```

### Create a swarm
This is one-liner that you do on SwarmManger machine. Take a look at the output which tells how to add nodes to just created swarm.
```sh
dkr@SwarmManager:~$ docker swarm init --advertise-addr 192.168.1.100
Swarm initialized: current node (5yb1pr0lfgbmt8n3byck1kvng) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join \
    --token SWMTKN-1-5x770oq91omm7yqh8r1afoagqwf6neqq6xf3iyrqjq1ejha9g6-3styjwv1kxua5spm1h7fp8rkx \
    192.168.1.100:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

### Create nodes
To add a node to a swarm go to the relevant machine and execute a command that was suggested while creation of a swarm.
```sh
dkr@SwarmNode1:~$ docker swarm join \
> --token SWMTKN-1-5x770oq91omm7yqh8r1afoagqwf6neqq6xf3iyrqjq1ejha9g6-3styjwv1kxua5spm1h7fp8rkx \
> 192.168.1.100:2377
This node joined a swarm as a worker.
```
You can get it at any time by executing the following on Swarm Manager:
```sh
dkr@SwarmManager:~$ # to get the token for a worker
dkr@SwarmManager:~$ docker swarm join-token worker 
To add a worker to this swarm, run the following command:

    docker swarm join \
    --token SWMTKN-1-5x770oq91omm7yqh8r1afoagqwf6neqq6xf3iyrqjq1ejha9g6-3styjwv1kxua5spm1h7fp8rkx \
    192.168.1.100:2377

dkr@SwarmManager:~$ # to get the token for another manager
dkr@SwarmManager:~$ docker swarm join-token manager
To add a manager to this swarm, run the following command:

    docker swarm join \
    --token SWMTKN-1-5x770oq91omm7yqh8r1afoagqwf6neqq6xf3iyrqjq1ejha9g6-0vov9b8smhlwcvqrmox6zo1oq \
    192.168.1.100:2377

```

### Do some verification
```sh
dkr@SwarmManager:~$ docker node ls
ID                           HOSTNAME      STATUS  AVAILABILITY  MANAGER STATUS
5yb1pr0lfgbmt8n3byck1kvng *  SwarmManager  Ready   Active        Leader
bo04den7xvet0n7462pffrsig    SwarmNode2    Ready   Active        
bvbe4i5s5teerx7cnx5vhxqxk    SwarmNode3    Ready   Active        
cde8j6a4e20c7meb8ecrlc0vy    SwarmNode1    Ready   Active        

dkr@SwarmManager:~$ docker node ps SwarmManager
ID  NAME  IMAGE  NODE  DESIRED STATE  CURRENT STATE  ERROR

dkr@SwarmManager:~$ docker node ps SwarmNode1
ID  NAME  IMAGE  NODE  DESIRED STATE  CURRENT STATE  ERROR

dkr@SwarmManager:~$ docker node inspect SwarmManager 
[
    {
        "ID": "5yb1pr0lfgbmt8n3byck1kvng",
        "Version": {
            "Index": 10
        },
        "CreatedAt": "2016-09-27T11:33:18.900242647Z",
        "UpdatedAt": "2016-09-27T11:33:18.958754337Z",
        "Spec": {
            "Role": "manager",
            "Availability": "active"
        },
        "Description": {
            "Hostname": "SwarmManager",
            "Platform": {
                "Architecture": "x86_64",
                "OS": "linux"
            },
            "Resources": {
                "NanoCPUs": 1000000000,
                "MemoryBytes": 518459392
            },
            "Engine": {
                "EngineVersion": "1.12.1",
                "Plugins": [
                    {
                        "Type": "Network",
                        "Name": "bridge"
                    },
                    {
                        "Type": "Network",
                        "Name": "host"
                    },
                    {
                        "Type": "Network",
                        "Name": "null"
                    },
                    {
                        "Type": "Network",
                        "Name": "overlay"
                    },
                    {
                        "Type": "Volume",
                        "Name": "local"
                    }
                ]
            }
        },
        "Status": {
            "State": "ready"
        },
        "ManagerStatus": {
            "Leader": true,
            "Reachability": "reachable",
            "Addr": "192.168.1.100:2377"
        }
    }
]
dkr@SwarmManager:~$ docker node inspect SwarmNode1 
[
    {
        "ID": "cde8j6a4e20c7meb8ecrlc0vy",
        "Version": {
            "Index": 16
        },
        "CreatedAt": "2016-09-27T11:39:41.963268366Z",
        "UpdatedAt": "2016-09-27T11:39:42.01546615Z",
        "Spec": {
            "Role": "worker",
            "Availability": "active"
        },
        "Description": {
            "Hostname": "SwarmNode1",
            "Platform": {
                "Architecture": "x86_64",
                "OS": "linux"
            },
            "Resources": {
                "NanoCPUs": 1000000000,
                "MemoryBytes": 518459392
            },
            "Engine": {
                "EngineVersion": "1.12.1",
                "Plugins": [
                    {
                        "Type": "Network",
                        "Name": "bridge"
                    },
                    {
                        "Type": "Network",
                        "Name": "host"
                    },
                    {
                        "Type": "Network",
                        "Name": "null"
                    },
                    {
                        "Type": "Network",
                        "Name": "overlay"
                    },
                    {
                        "Type": "Volume",
                        "Name": "local"
                    }
                ]
            }
        },
        "Status": {
            "State": "ready"
        }
    }
]

dkr@SwarmManager:~$ docker info
Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
Images: 4
Server Version: 1.12.1
Storage Driver: aufs
 Root Dir: /var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 11
 Dirperm1 Supported: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge host null overlay
Swarm: active
 NodeID: 5yb1pr0lfgbmt8n3byck1kvng
 Is Manager: true
 ClusterID: dnyy6nhl85woadhlxnje1to6c
 Managers: 1
 Nodes: 4
 Orchestration:
  Task History Retention Limit: 5
 Raft:
  Snapshot Interval: 10000
  Heartbeat Tick: 1
  Election Tick: 3
 Dispatcher:
  Heartbeat Period: 5 seconds
 CA Configuration:
  Expiry Duration: 3 months
 Node Address: 192.168.1.100
Runtimes: runc
Default Runtime: runc
Security Options:
Kernel Version: 3.16.0-4-amd64
Operating System: Debian GNU/Linux 8 (jessie)
OSType: linux
Architecture: x86_64
CPUs: 1
Total Memory: 494.4 MiB
Name: SwarmManager
ID: T6BQ:ZTQD:FYSN:ESCA:DM3G:EUEC:ACQZ:PQJT:PYZZ:MY44:A3TL:I6SS
Docker Root Dir: /var/lib/docker
Debug Mode (client): false
Debug Mode (server): false
Registry: https://index.docker.io/v1/
WARNING: No memory limit support
WARNING: No swap limit support
WARNING: No kernel memory limit support
WARNING: No oom kill disable support
WARNING: No cpu cfs quota support
WARNING: No cpu cfs period support
Insecure Registries:
 127.0.0.0/8

dkr@SwarmNode1:~$ docker info
Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
Images: 3
Server Version: 1.12.1
Storage Driver: aufs
 Root Dir: /var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 7
 Dirperm1 Supported: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge host overlay null
Swarm: active
 NodeID: cde8j6a4e20c7meb8ecrlc0vy
 Is Manager: false
 Node Address: 192.168.1.101
Runtimes: runc
Default Runtime: runc
Security Options:
Kernel Version: 3.16.0-4-amd64
Operating System: Debian GNU/Linux 8 (jessie)
OSType: linux
Architecture: x86_64
CPUs: 1
Total Memory: 494.4 MiB
Name: SwarmNode1
ID: GU7D:AQSG:OXMK:FM2I:6RLO:UXJV:RSL7:XNPY:KZS3:J5RJ:EZXO:YKRN
Docker Root Dir: /var/lib/docker
Debug Mode (client): false
Debug Mode (server): false
Registry: https://index.docker.io/v1/
WARNING: No memory limit support
WARNING: No swap limit support
WARNING: No kernel memory limit support
WARNING: No oom kill disable support
WARNING: No cpu cfs quota support
WARNING: No cpu cfs period support
Insecure Registries:
 127.0.0.0/8

```

### Deploy a service into swarm
We will deploy a good old and beloved nginx. We will map innternal port 80 to external port 8080:
```sh
dkr@SwarmManager:~$ docker service create --replicas 1 --name MaybeRussianButWorks -p 8080:80 nginx
erg4hidfm2gajengdaae1mj6j
```
Now let's find out what's going on:
```sh
dkr@SwarmManager:~$ docker service ls
ID            NAME                  REPLICAS  IMAGE  COMMAND
erg4hidfm2ga  MaybeRussianButWorks  1/1       nginx  

dkr@SwarmManager:~$ docker service ps MaybeRussianButWorks
ID                         NAME                    IMAGE  NODE          DESIRED STATE  CURRENT STATE           ERROR
buuaj1t0iz4v9z6gb2vzgq8vs  MaybeRussianButWorks.1  nginx  SwarmManager  Running        Running 10 minutes ago  
```
I don't like that replica runs on SwarmManager. Let's prevent it:
```sh
dkr@SwarmManager:~$ docker node update SwarmManager --availability drain
SwarmManager

dkr@SwarmManager:~$ docker service ps MaybeRussianButWorks
ID                         NAME                        IMAGE  NODE          DESIRED STATE  CURRENT STATE                ERROR
bmrw1ttfvv5y40cw6agbr4oa4  MaybeRussianButWorks.1      nginx  SwarmNode2    Running        Running 57 seconds ago       
buuaj1t0iz4v9z6gb2vzgq8vs   \_ MaybeRussianButWorks.1  nginx  SwarmManager  Shutdown       Shutdown about a minute ag
```
The ```--availability drain``` can be set while joining a machine as manager. Now let's find out what happens if we shut down thhe working node:
```sh
root@SwarmNode2:~# service docker stop
root@SwarmNode2:~# service docker status
● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; enabled)
   Active: inactive (dead) since Tue 2016-09-27 08:22:37 EDT; 5s ago
     Docs: https://docs.docker.com
  Process: 515 ExecStart=/usr/bin/dockerd -H fd:// (code=exited, status=0/SUCCESS)
 Main PID: 515 (code=exited, status=0/SUCCESS)

dkr@SwarmManager:~$ docker service ps MaybeRussianButWorks
ID                         NAME                        IMAGE  NODE          DESIRED STATE  CURRENT STATE           ERROR
1y6tz84xrtucge7m1s9oizs61  MaybeRussianButWorks.1      nginx  SwarmNode1    Running        Running 21 seconds ago  
bmrw1ttfvv5y40cw6agbr4oa4   \_ MaybeRussianButWorks.1  nginx  SwarmNode2    Shutdown       Running 5 minutes ago   
buuaj1t0iz4v9z6gb2vzgq8vs   \_ MaybeRussianButWorks.1  nginx  SwarmManager  Shutdown       Shutdown 5 minutes ago
```
