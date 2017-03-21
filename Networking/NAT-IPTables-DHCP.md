### Scenario
```bash
Router platoform:
        Raspberry Pi with Raspbian Jessie
        
WAN:    
        interface wlan0 (WiFi)
        network 192.168.14.0
        address 192.168.14.2
        netmask 255.255.255.0
        gateway 192.168.14.1
        broadcast 192.168.14.255
        dns-nameservers 192.168.14.1

LAN:
        interface eth0 (copper)
        network 192.168.16.0
        address 192.168.16.1
        netmask 255.255.255.0
        broadcast 192.168.16.255
```
### Prerequisites
```bash
apt-get install isc-dhcp-server
```

### /etc/sysctl.conf
```bash
(...)
net.ipv4.ip_forward=1
(...)
```
### /etc/iptables.rules
Do not implement this in unsafe environments. This rules allows in- and outband traffic!

```bash
*nat
-A POSTROUTING -o wlan0 -j MASQUERADE
COMMIT

*filter
-A FORWARD -i eth0  -o wlan0 -j ACCEPT
-A FORWARD -i wlan0 -o eth0  -m state --state RELATED,ESTABLISHED -j ACCEPT
COMMIT
```
### /etc/default/isc-dhcp-server
```bash
(...)
INTERFACES="eth0"
(...)
```

### /etc/dhcp/dhcpd.conf
```bash
ddns-update-style none;

option domain-name-servers 192.168.14.1, 8.8.4.4, 8.8.8.8;

default-lease-time 86400;
max-lease-time 604800;

authoritative;

subnet 192.168.16.0 netmask 255.255.255.0 {
        range 192.168.16.100 192.168.16.199;
        option subnet-mask 255.255.255.0;
        option broadcast-address 192.168.16.255;
        option routers 192.168.16.1;
}
```
### /etc/network/interfaces
```bash
auto lo
iface lo inet loopback

#IPTABLES:
pre-up iptables-restore < /etc/iptables.rules

#WAN:
auto wlan0
iface wlan0 inet static
        network 192.168.14.0
        address 192.168.14.2
        netmask 255.255.255.0
        gateway 192.168.14.1
        broadcast 192.168.14.255
        dns-nameservers 192.168.14.1
        wpa-ssid   "MyNetworkSSID"
        wpa-psk    "MyNetworkPassword"
        
#LAN:
auto eth0
iface eth0 inet static
        network 192.168.16.0
        address 192.168.16.1
        netmask 255.255.255.0
        broadcast 192.168.16.255
```
