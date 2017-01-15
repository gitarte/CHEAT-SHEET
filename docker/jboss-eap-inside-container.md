### Prepare direcotry for your work
```sh
[artgaw@T7500 image]$ ls
build.sh  Dockerfile  jboss-eap-7.0  jdk-8u112-linux-x64.rpm  minimal.war
```
Where:
```
Dockerfile              # Docker image definition
build.sh                # build image -> run container
jboss-eap-7.0           # JBoss EAP 7 (already unzipped)
jdk-8u112-linux-x64.rpm # Oracle JDK8 installator 
minimal.war             # application to deploy
```
### Dockerfile
```sh
FROM   centos
EXPOSE 8080
EXPOSE 9990
ENV    EAP_HOME=/opt/jboss-eap-7.0/
COPY   ["jdk-8u112-linux-x64.rpm", "/opt/jdk-8u112-linux-x64.rpm"]
RUN    ["rpm", "-ivh", "/opt/jdk-8u112-linux-x64.rpm"]
COPY   ["jboss-eap-7.0", "/opt/jboss-eap-7.0/"]
RUN    ["/opt/jboss-eap-7.0/bin/add-user.sh", "admin", "eapadmin", "--silent"]
COPY   ["minimal.war", "/opt/jboss-eap-7.0/standalone/deployments/minimal.war"]
CMD    ["/opt/jboss-eap-7.0/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
```
### build.sh
```sh
docker build -t bsk-jboss . && \
docker run -d \
    -p 80:8080 \
    -p 9990:9990 \
    --name jboss \
    bsk-jboss
```
### Enjoy the results
```
http://localhost/minimal/
http://localhost:9990/    l:admin, p:eapadmin
```
