# How to create a custom DNS server
### The background
```
* operating system: CentOS7
* network:          192.168.122.0/24
* nameserver:       192.168.122.10
* domain name:      artgaw.pl 
```
### The goal
```sh
         artgaw.pl -> 192.168.122.1
   ocdns.artgaw.pl -> 192.168.122.10
ocmaster.artgaw.pl -> 192.168.122.100
ocnode01.artgaw.pl -> 192.168.122.101
ocnode02.artgaw.pl -> 192.168.122.102
```
### Install DNS software
```bash
yum -y install bind bind-utils
```
### Add zones into /etc/named.conf
```bash
zone "artgaw.pl" IN {
    type master;
    file "forward.artgaw.pl";
    allow-update { none; };
};
zone "122.168.192.in-addr.arpa" IN {
    type master;
    file "reverse.artgaw.pl";
    allow-update { none; };
};
```
### Accept external queries in /etc/named.conf (here permission is granted for 192.168.122.0/24)
```bash
allow-query     { 192.168.122.0/24; localhost; };
```
### Allow forwarding to external DNS servers
```bash
forwarders {
       8.8.8.8;
       8.8.4.4;
       192.168.122.1;
};
```
### Create /var/named/forward.artgaw.pl
```bash
$TTL 86400
@   IN  SOA     ocdns.artgaw.pl. root.artgaw.pl. (
    2011071001  ;Serial
    3600        ;Refresh
    1800        ;Retry
    604800      ;Expire
    86400       ;Minimum TTL
)
@           IN  NS  ocdns.artgaw.pl.
@           IN  A   192.168.122.1
ocdns       IN  A   192.168.122.10
ocmaster    IN  A   192.168.122.100
ocnode01    IN  A   192.168.122.101
ocnode02    IN  A   192.168.122.102
```
### Create /var/named/reverse.artgaw.pl
```bash
$TTL 86400
@   IN  SOA     ocdns.artgaw.pl. root.artgaw.pl. (
    2011071001  ;Serial
    3600        ;Refresh
    1800        ;Retry
    604800      ;Expire
    86400       ;Minimum TTL
)
@           IN  NS      ocdns.artgaw.pl.
@           IN  PTR           artgaw.pl.
ocdns       IN  A   192.168.122.10
ocmaster    IN  A   192.168.122.100
ocnode01    IN  A   192.168.122.101
ocnode02    IN  A   192.168.122.102
1           IN  PTR           artgaw.pl.
10          IN  PTR     ocdns.artgaw.pl.
100         IN  PTR  ocmaster.artgaw.pl.
101         IN  PTR  ocnode01.artgaw.pl.
102         IN  PTR  ocnode02.artgaw.pl.

```
### Deal with ownership of the files
```bash
chown root:named /var/named/*.artgaw.pl
```
### Start the DNS software
```
systemctl enable named
systemctl start  named
```
### Perform some testing
```bash
[root@client ~]# named-checkconf /etc/named.conf
(no output is correct)

[root@client ~]# named-checkzone artgaw.pl /var/named/forward.artgaw.pl 
zone artgaw.pl/IN: loaded serial 2011071001
OK

[root@client ~]# named-checkzone artgaw.pl /var/named/reverse.artgaw.pl 
zone artgaw.pl/IN: loaded serial 2011071001
OK
```
```bash
[root@client ~]# dig +noall +answer @192.168.122.10 artgaw.pl
artgaw.pl.		86400	IN	A	192.168.122.1

[root@client ~]# dig +noall +answer @192.168.122.10 ocdns.artgaw.pl
ocdns.artgaw.pl.	86400	IN	A	192.168.122.10

[root@client ~]# dig +noall +answer @192.168.122.10 ocmaster.artgaw.pl
ocmaster.artgaw.pl.	86400	IN	A	192.168.122.100

[root@client ~]# dig +noall +answer @192.168.122.10 ocnode01.artgaw.pl
ocnode01.artgaw.pl.	86400	IN	A	192.168.122.101

[root@client ~]# dig +noall +answer @192.168.122.10 ocnode02.artgaw.pl
ocnode02.artgaw.pl.	86400	IN	A	192.168.122.102
```
```bash
[root@client ~]# host 192.168.122.1
1.122.168.192.in-addr.arpa domain name pointer artgaw.pl.

[root@client ~]# host 192.168.122.10
10.122.168.192.in-addr.arpa domain name pointer ocdns.artgaw.pl.

[root@client ~]# host 192.168.122.100
100.122.168.192.in-addr.arpa domain name pointer ocmaster.artgaw.pl.

[root@client ~]# host 192.168.122.101
101.122.168.192.in-addr.arpa domain name pointer ocnode01.artgaw.pl.

[root@client ~]# host 192.168.122.102
102.122.168.192.in-addr.arpa domain name pointer ocnode02.artgaw.pl.
```
