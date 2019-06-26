# INSTALL DOCKER 
### UBUNTU 16.04
```bash
set -x \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
&& add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
&& apt-get update \
&& apt-get install -y docker-ce \
&& usermod -aG docker ENTER_UNPRIVILEGED_USERS_NAME_HERE \
&& systemctl enable docker \ 
&& echo "=== ALL DONE ==="
```
Finally reboot your machine
### UBUNTU 17.10
```bash
set -x \
&& apt install -y vim geany curl git apt-transport-https ca-certificates software-properties-common \
&& curl -O https://download.docker.com/linux/ubuntu/dists/zesty/pool/stable/amd64/docker-ce_17.09.0~ce-0~ubuntu_amd64.deb \
&& dpkg -i docker-ce_17.09.0~ce-0~ubuntu_amd64.deb \
&& usermod -aG docker ENTER_UNPRIVILEGED_USERS_NAME_HERE \
&& systemctl enable docker \
&& systemctl restart docker \
&& echo "=== ALL DONE ==="
```
### UBUNTU 18.04 AND 19.04
```
sudo echo "Let's install docker-ce and docker-compose" \
&& sudo apt -y install apt-transport-https ca-certificates curl software-properties-common \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
&& sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" \
&& sudo apt -y update \
&& sudo apt -y install docker-ce \
&& sudo usermod -aG docker ${USER} \
&& sudo systemctl enable docker \
&& sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
&& sudo chmod +x /usr/local/bin/docker-compose \
&& docker version \
&& docker-compose version \
&& echo "=== ALL DONE ==="
```
Finally reboot your machine
### DEBIAN 8.x
```bash
echo "Let's install docker-ce" \
&& apt-get -y install apt-transport-httrver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
&& echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> /etc/apt/sources.list \
&& apt-get -y update \
&& apt-get -y install docker-engine \
&& adduser -g docker docker \
&& systemctl enable docker.service \
&& echo "=== ALL DONE ==="
```
Finally reboot your machine
### DEBIAN 9.x
Sitch into `root` first, remember to set destination username by setting `${USER}` correctly
```bash
echo "Let's install docker-ce and docker-compose" \
&& apt -y update \
&& apt -y upgrade \
&& apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common \
&& apt -y install git vim openssh-* \
&& curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
&& add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
&& apt -y update \
&& apt -y install docker-ce docker-ce-cli containerd.io \
&& usermod -aG docker ${USER} \
&& systemctl enable docker \
&& curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
&& chmod +x /usr/local/bin/docker-compose \
&& echo "=== ALL DONE ==="
```
Finally reboot your machine

### CENTOS 7.x
Add repo
```bash
tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
```
Run installation procedure
```bash
set -x \
&& yum -y update \
&& yum -y install docker-engine \
&& adduser -g docker docker \
&& usermod -aG docker ENTER_UNPRIVILEGED_USERS_NAME_HERE \
&& systemctl enable docker.service \
&& systemctl start docker \
&& echo "=== ALL DONE ==="
```
Finally reboot your machine
