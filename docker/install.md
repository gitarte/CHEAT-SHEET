# INSTALL DOCKER 

### UBUNTU >= 19.04
```
sudo echo "Let's install docker-ce and docker-compose" \
&& sudo apt -y install apt-transport-https ca-certificates curl software-properties-common \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
&& sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" \
&& sudo apt -y update \
&& sudo apt -y install docker-ce \
&& sudo usermod -aG docker ${USER} \
&& sudo systemctl enable docker \
&& sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
&& sudo chmod +x /usr/local/bin/docker-compose \
&& sudo docker version \
&& sudo docker-compose version \
&& sudo echo "=== ALL DONE ==="
```

### DEBIAN >= 10
Switch into `root` first, remember to set destination username by setting `${USER}` correctly
```bash
echo "Let's install docker-ce and docker-compose" \
&& apt -y update \
&& apt -y upgrade \
&& apt -y install git vim openssh-* \
&& apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common \
&& curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
&& add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
&& apt -y update \
&& apt -y install docker-ce docker-ce-cli containerd.io \
&& usermod -aG docker ${MY_USER} \
&& systemctl enable docker \
&& curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
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
