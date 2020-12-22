# DIY MAIL SERVER
Installing and configureing basic mailserver based on `postfix` and `dovecot`

## setup DNS
The example domain is `artgaw.pl` and mail server has IP `192.168.43.200`

### make DNS resolution to read the hosts file first
```bash
echo "order hosts,bind" | cat - /etc/host.conf > temp && mv temp /etc/host.conf
```

### setup FQDN
```bash
hostnamectl set-hostname mail.artgaw.pl
echo "192.168.43.200 artgaw.pl mail.artgaw.pl" >> /etc/hosts
systemctl reboot 
```

### ensure the resutls after reboot 
```bash
cat /etc/host.conf
cat /etc/hostname 
hostname
hostname -s
hostname -f
hostname -A
hostname -i
getent ahosts mail.artgaw.pl
ping -c4 artgaw.pl
ping -c4 mail.artgaw.pl
```

## install the software
Example covers `Debian 10`
```bash
apt -y update
apt -y upgrade
apt -y install vim curl wget netcat net-tools bash-completion lsof certbot
apt -y install mailutils
apt -y install postfix
apt -y install dovecot-core dovecot-imapd
```

## setup the postfix
```bash
mv  /etc/postfix/main.cf /etc/postfix/main.cf.bkp
cat <<EOT > /etc/postfix/main.cf
# See /usr/share/postfix/main.cf.dist for a commented, more complete version
smtpd_banner = $myhostname ESMTP $mail_name
biff = no

# appending .domain is the MUA's job.
append_dot_mydomain = no
readme_directory = no

# See http://www.postfix.org/COMPATIBILITY_README.html -- default to 2 on fresh installs.
compatibility_level = 2

# TLS parameters
smtpd_tls_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
smtpd_tls_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
smtpd_use_tls=yes
smtpd_tls_session_cache_database = btree:${data_directory}/smtpd_scache
smtp_tls_session_cache_database = btree:${data_directory}/smtp_scache

# See /usr/share/doc/postfix/TLS_README.gz in the postfix-doc package for
# information on enabling SSL in the smtp client.

smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
myhostname = mail.artgaw.pl
mydomain = artgaw.pl
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
myorigin = artgaw.pl
mydestination = mail.artgaw.pl, artgaw.pl, localhost.artgaw.pl, localhost
relayhost = 
mynetworks = 127.0.0.0/8, 192.168.43.0/24
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = all
inet_protocols = ipv4
home_mailbox = Maildir/

# SMTP-Auth settings
smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_sasl_auth_enable = yes
smtpd_sasl_security_options = noanonymous
smtpd_sasl_local_domain = $myhostname
smtpd_recipient_restrictions = permit_mynetworks,permit_auth_destination,permit_sasl_authenticated,reject
EOT

echo "export MAIL=$HOME/Maildir" >> /etc/profile
```

## verify the configuration, restart postfix and check if it is listening on port 25
```bash
postconf -n
systemctl restart postfix
systemctl status postfix
netstat -ntdupa
```

## configure dovecot 
```bash
cp /etc/dovecot/dovecot.conf          /etc/dovecot/dovecot.conf.bkp
cp /etc/dovecot/conf.d/10-auth.conf   /etc/dovecot/conf.d/10-auth.conf.bkp
cp /etc/dovecot/conf.d/10-mail.conf   /etc/dovecot/conf.d/10-mail.conf.bkp
cp /etc/dovecot/conf.d/10-master.conf /etc/dovecot/conf.d/10-master.conf.bkp

# listen = *, ::
vim /etc/dovecot/dovecot.conf

# disable_plaintext_auth = no
# auth_mechanisms = plain login
vim /etc/dovecot/conf.d/10-auth.conf

# mail_location = maildir:~/Maildir
vim /etc/dovecot/conf.d/10-mail.conf

# unix_listener /var/spool/postfix/private/auth {
#   mode = 0666
#   user = postfix
#   group = postfix
# }
vim /etc/dovecot/conf.d/10-master.conf
```

## verify the configuration, restart dovecot and chgeck if it is listening on port 143
```bash
systemctl restart dovecot
systemctl status dovecot
netstat -ntdupa
```

## try to create new user and send mail to him
### create the user
```bash
adduser qqryq
```

### send mail using `mail` tool
```bash
mkdir -p ~/Maildir/new/
echo "test body" | mail -s "test mail" qqryq
mailq
mail
ls  ~/Maildir/
ls  ~/Maildir/new/
cat ~/Maildir/new/*
```

### send mail using `netcat`
```bash
nc localhost 25
# ehlo localhost
# mail from: root
# rcpt to: qqryq
# data
# subject: test
# Mail body
# .
# quit
```

## verifie delivery
### thoe basic way
```bash
ls /home/qqryq/Maildir/new/
```

### the IMAP way
```bash
nc localhost 143
x1 LOGIN qqryq dupa1
x2 LIST "" "*"
x3 SELECT Inbox
x4 LOGOUT
```
