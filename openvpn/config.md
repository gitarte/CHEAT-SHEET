### Create certs
```sh
cd /etc/openvpn/easy-rsa/
source ./vars 
./clean-all 
./build-ca 
./build-key-server zfs
./build-dh 
cd /etc/openvpn/easy-rsa/keys/
cp dh2048.pem ca.crt zfs.crt zfs.key /etc/openvpn/
cd /etc/openvpn/easy-rsa/
./build-key arga-1-zfs
cd /etc/openvpn/easy-rsa/keys/
cp *crt /root/keys
cp *key /root/keys
```
### Server's config
```sh
cat <<EOT >> /etc/openvpn/server.conf
port 2193
proto udp
dev tun
ca ca.crt
cert zfs.crt
dh dh2048.pem
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
keepalive 10 120
comp-lzo
user nobody
group nobody
persist-key
persist-tun
status openvpn-status.log
log-append  openvpn.log
verb 3
EOT

# I'm not sure about this:
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables-save > /etc/sysconfig/iptables-config 
iptables-save > /etc/sysconfig/iptables
```

### Generate client's config
```sh
cd /root/keys
cat <<EOT >> arga-1-zfs.ovpn
client
port 2193
remote 86.105.51.161
comp-lzo yes
dev tun
proto udp
nobind
auth-nocache
persist-key
persist-tun
verb 2
key-direction 1
<ca>
EOT
cat ca.crt >> arga-1-zfs.ovpn 
cat <<EOT >> arga-1-zfs.ovpn
</ca>
<cert>
EOT
cat arga-1-zfs.crt >> arga-1-zfs.ovpn 
cat <<EOT >> arga-1-zfs.ovpn
</cert>
<key>
EOT
cat arga-1-zfs.key >> arga-1-zfs.ovpn 
echo '</key>' >> arga-1-zfs.ovpn 
systemctl restart openvpn@server.service
```
