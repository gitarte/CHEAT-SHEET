### On Ubuntu
Download and extract JDK. In this example ```jdk-8u144-linux-x64.tar.gz```
```sh
JDK=jdk1.8.0_144
mkdir /usr/lib/jvm
mv $JDK /usr/lib/jvm/
update-alternatives --install "/usr/bin/java"   "java"   "/usr/lib/jvm/$JDK/bin/java"   1
update-alternatives --install "/usr/bin/javac"  "javac"  "/usr/lib/jvm/$JDK/bin/javac"  1
update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/$JDK/bin/javaws" 1
chmod a+x /usr/bin/java
chmod a+x /usr/bin/javac
chmod a+x /usr/bin/javaws
```
In case when openjdk is steel a default for java use
```sh
update-alternatives --config java
```
