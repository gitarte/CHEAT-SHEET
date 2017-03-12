```bash
#/etc/ssh/ssh_config: 
  ServerAliveInterval 60

#/etc/ssh/sshd_config:
  ClientAliveInterval 30
  TCPKeepAlive yes
  ClientAliveCountMax 99999
```
