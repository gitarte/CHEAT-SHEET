```file .bashrc```

```sh
alias idea='idea.sh 1>/dev/null 2>/dev/null &'

JAVA_HOME=/usr/lib/jvm/jdk1.8.0_144
JDK_HOME=$JAVA_HOME
JRE_HOME=$JAVA_HOME/jre
MAVEN_HOME=/usr/local/apache-maven-3.5.0
IDEA_HOME=/usr/local/idea-IC-172.3544.35

GOPATH=$HOME/gocode
GOROOT=/usr/local/go
LITEPATH=/usr/local/liteide
PYCHARM=/usr/local/pycharm-community-5.0.4
ARDUINOPATH=/usr/local/arduino-1.6.7
PATH=$PATH:$HOME/.local/bin:$HOME/bin:$MAVEN_HOME/bin:$IDEA_HOME/bin:$GOROOT/bin:$GOPATH/bin:$LITEPATH/bin:$PYCHARM/bin:$ARDUINOPATH
```
