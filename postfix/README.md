# DIY MAIL SERVER

Example installation and configuration of basic mail server based on `postfix` and `dovecot` with TLS cert obtained from `let's encrypt`

## setup the DNS

The example domain is `sp9ag.pl` and mail server is `mail.sp9ag.pl` which points into `192.168.43.200`

### make DNS resolution to read the hosts file first

```bash
echo "order hosts,bind" | cat - /etc/host.conf > temp && mv temp /etc/host.conf
```

### setup FQDN

```bash
hostnamectl set-hostname mail.sp9ag.pl
echo "192.168.43.200 sp9ag.pl mail.sp9ag.pl" >> /etc/hosts
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
getent ahosts mail.sp9ag.pl
ping -c4 sp9ag.pl
ping -c4 mail.sp9ag.pl
```

## install the software

Example covers `Debian 10`

```bash
   apt -y update \
&& apt -y upgrade \
&& apt -y install libsasl2-dev libsasl2-modules \
&& apt -y install vim curl wget netcat net-tools bash-completion lsof certbot mailutils \
&& apt -y install postfix \
&& apt -y install dovecot-core dovecot-common dovecot-imapd dovecot-pop3d \
&& apt -y autoremove \
&& apt -y autoclean \
&& apt -y clean \
&& echo "======= OK ======="
```

## obtain the cert's from `let's encrypt`

```bash
certbot certonly --standalone -d mail.sp9ag.pl
```

## setup the postfix

```bash
mv  /etc/postfix/main.cf   /etc/postfix/main.cf.bkp
mv  /etc/postfix/master.cf /etc/postfix/master.cf.bkp

# submission inet n - - - - smtpd
#   -o syslog_name=postfix/submission
#   -o smtpd_tls_security_level=encrypt
#   -o smtpd_sasl_auth_enable=yes
#   -o smtpd_client_restrictions=permit_sasl_authenticated,reject
# smtps inet n - - - - smtpd
#   -o syslog_name=postfix/smtps
#   -o smtpd_tls_wrappermode=yes
#   -o smtpd_sasl_auth_enable=yes
#   -o smtpd_client_restrictions=permit_sasl_authenticated,reject
vim /etc/postfix/master.cf

cat <<EOT > /etc/postfix/main.cf
alias_database                   = hash:/etc/aliases
alias_maps                       = hash:/etc/aliases
append_dot_mydomain              = no
biff                             = no
broken_sasl_auth_clients         = yes
compatibility_level              = 2
disable_vrfy_command             = yes
home_mailbox                     = Maildir/
inet_interfaces                  = all
inet_protocols                   = ipv4
mailbox_size_limit               = 0
mydestination                    = mail.sp9ag.pl, sp9ag.pl, localhost.sp9ag.pl, localhost
mydomain                         = sp9ag.pl
myhostname                       = mail.sp9ag.pl
mynetworks                       = 127.0.0.0/8, 192.168.43.0/24
myorigin                         = sp9ag.pl
readme_directory                 = no
recipient_delimiter              = +
relayhost                        = 
smtp_tls_note_starttls_offer     = yes
smtp_tls_security_level          = may
smtp_tls_session_cache_database  = btree:${data_directory}/smtp_scache
smtpd_banner                     = mail.sp9ag.pl ESMTP
smtpd_delay_reject               = yes
smtpd_helo_required              = yes
smtpd_helo_restrictions          = reject_non_fqdn_helo_hostname,reject_invalid_helo_hostname,reject_unknown_helo_hostname
smtpd_recipient_restrictions     = permit_sasl_authenticated,permit_mynetworks,reject_unauth_destination,reject_invalid_hostname,reject_non_fqdn_hostname,reject_non_fqdn_sender,reject_non_fqdn_recipient,reject_unknown_sender_domain,reject_rbl_client sbl.spamhaus.org,reject_rbl_client cbl.abuseat.org
smtpd_relay_restrictions         = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
smtpd_sasl_auth_enable           = yes
smtpd_sasl_local_domain          =
smtpd_sasl_path                  = private/auth
smtpd_sasl_security_options      = noanonymous
smtpd_sasl_type                  = dovecot
smtpd_tls_cert_file              = /etc/letsencrypt/live/mail.sp9ag.pl/fullchain.pem
smtpd_tls_key_file               = /etc/letsencrypt/live/mail.sp9ag.pl/privkey.pem
smtpd_tls_loglevel               = 1
smtpd_tls_received_header        = yes
smtpd_tls_security_level         = may
smtpd_tls_session_cache_database = btree:${data_directory}/smtpd_scache
smtpd_use_tls                    = yes
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
cp /etc/dovecot/conf.d/10-ssl.conf    /etc/dovecot/conf.d/10-ssl.conf.bkp

# listen = *, ::
vim /etc/dovecot/dovecot.conf

# disable_plaintext_auth = yes
# auth_mechanisms = plain login
vim /etc/dovecot/conf.d/10-auth.conf

# mail_location = maildir:~/Maildir
vim /etc/dovecot/conf.d/10-mail.conf

# service imap-login {
# ...
#  inet_listener imap {
#    port = 143
#  }
#  inet_listener imaps {
#    port = 993
#    ssl = yes
#  }
# ...
# }
# service pop3-login {
#   inet_listener pop3 {
#     port = 110
#   }
#   inet_listener pop3s {
#     port = 995
#     ssl = yes
#   }
# }
# ...
# service auth {
# ...
#    # Postfix smtp-auth
#    unix_listener /var/spool/postfix/private/auth {
#       mode = 0660
#       user = postfix
#       group = postfix
# }
vim /etc/dovecot/conf.d/10-master.conf

# ssl = required
# ssl_cert = </etc/letsencrypt/live/mail.sp9ag.pl/fullchain.pem
# ssl_key = </etc/letsencrypt/live/mail.sp9ag.pl/privkey.pem
# ssl_protocols = !SSLv2 !SSLv3
vim /etc/dovecot/conf.d/10-ssl.conf
```

## verify the configuration, restart dovecot and check if it is listening on port 143 and 110

```bash
dovecot -n
systemctl restart dovecot
systemctl status dovecot
netstat -ntdupa
```

## create a bunch of new users and send mail to at least one of them

### create the users

```bash
useradd -m admin
useradd -m biuro
useradd -m laser
useradd -m polev
useradd -m procopy
useradd -m procopych
useradd -m skaner

passwd     admin
passwd     biuro
passwd     laser
passwd     polev
passwd     procopy
passwd     procopych
passwd     skaner

newaliases
```

### send mail using `mail` tool

```bash
mkdir -p ~/Maildir/new/
echo "test body" | mail -s "test mail" admin
mailq
mail
```

### send mail using `netcat`

```bash
nc localhost 25
# ehlo localhost
# mail from: root
# rcpt to: admin
# data
# subject: test
# Mail body
# .
# quit
```

## verify delivery

### the basic way

```bash
ls  /home/admin/Maildir/
ls  /home/admin/Maildir/new/
cat /home/admin/Maildir/new/*
```

### the IMAP way

```bash
nc localhost 143
x1 LOGIN admin relevant_password
x2 LIST "" "*"
x3 SELECT Inbox
x4 LOGOUT
```
