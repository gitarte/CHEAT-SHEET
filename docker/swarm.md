# DOCKER-SWARM
This cheat-sheet presents task to be done while creating and managing basic docker-swarm cluster. Machines ```dock1```, ```dock2``` and ```dock3``` are visible over network and their hostnames can be resolved to IP addresses thanks to ```/etc/hosts``` file. also following ports have to be opened:
```sh
TCP         port 2377 for cluster management communications
TCP and UDP port 7946 for communication among nodes
TCP and UDP port 4789 for overlay network traffic
```
### 1. Install docker-engine on each machine
Follow this instruction [install]
### 2. Create a swarm
On ```dock1``` execute
```sh
$ docker swarm init --advertise-addr [put IP not host name here]
```
Also on ```dock1``` execute following command. The output shows what to type on other hosts to join them to the swarm. 
```sh
$ docker swarm join-token manager
To add a manager to this swarm, run the following command:

    docker swarm join \
    --token SWMTKN-1-5uw89zgwrlzdd9i82tz3p1p615lfel2qma134us8u6lzhco9ex-coxnesdpircrjvlm5mm07fhek \
    [put IP of dock1 here]:2377
```
### 3. Join other master nodes to the swarm
On ```dock1```and ```dock2``` execute the command that you have obtained in prevoiuse step. Replace ```[put IP of dock1 here]``` with IP of ```dock1``
```sh
$ # Don't copy and paste this. You will have different token! Read step 2.
$ docker swarm join \
--token SWMTKN-1-5uw89zgwrlzdd9i82tz3p1p615lfel2qma134us8u6lzhco9ex-coxnesdpircrjvlm5mm07fhek \
[put IP of dock1 here]:2377
```
### 4. Do some verification
On each machine execute following command. Each machine should return the same output
```sh
$ docker node ls
$ docker node ps dock1
$ docker node ps dock2
$ docker node ps dock3
$ docker node inspect dock1
$ docker node inspect dock2
$ docker node inspect dock3
```
### 5. Deploy a service into swarm
We will deploy a good old and beloved nginx. We will map innternal port 80 to external port 8080. You can execute this command on any machine since we have added each one as master node
```sh
$ docker service create --mode global --name RussianButWorks -p 8080:80 nginx
```
Now let's find out what's going on:
```sh
$ docker service ls
$ docker service ps RussianButWorks
```
[install]: <https://github.com/gitarte/CHEAT-SHEET/blob/master/docker/install.md>
