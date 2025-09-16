# certbot
certbot run --nginx -d slask-w-eterze.pl

# docker compose
services:
  app:
    image: wordpress:6.8.2-php8.1-apache
    restart: always
    ports:
      - 127.0.0.1:8082:80
    environment:
      WORDPRESS_DB_HOST:     db
      WORDPRESS_DB_USER:     db
      WORDPRESS_DB_PASSWORD: ShbPaSUb7z
      WORDPRESS_DB_NAME:     db
    volumes:
      - /home/slask_w_eterze_pl/app:/var/www/html

  db:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_DATABASE: db
      MYSQL_USER:     db
      MYSQL_PASSWORD: ShbPaSUb7z
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - /home/slask_w_eterze_pl/db:/var/lib/mysql

# app/wp-config.php
define('FORCE_SSL_ADMIN', true);
define('.COOKIE_DOMAIN.', 'slask-w-eterze.pl');
define('.SITECOOKIEPATH.', '.');
define('WP_HOME', 'https://slask-w-eterze.pl');
define('WP_SITEURL', 'https://slask-w-eterze.pl');
if (isset($_SERVER['HTTP_X_FORWARDED_FOR']))  { $list = explode(',',$_SERVER['HTTP_X_FORWARDED_FOR']);$_SERVER['REMOTE_ADDR'] = $list[0]; }
if (isset($_SERVER['HTTP_X_FORWARDED_HOST'])) { $_SERVER['HTTP_HOST'] = $_SERVER['HTTP_X_FORWARDED_HOST']; }
if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') { $_SERVER['HTTPS'] = 'on'; }
if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false) { $_SERVER['HTTPS'] = 'on'; }

# /etc/nginx/conf.d/slask_w_eterze_pl.conf
server {
    server_name  slask-w-eterze.pl;

    location / {
        proxy_pass http://127.0.0.1:8082;
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Host $server_name;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_redirect off;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/slask-w-eterze.pl/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/slask-w-eterze.pl/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    if ($host = slask-w-eterze.pl) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    server_name  slask-w-eterze.pl;
    listen 80;
    return 404; # managed by Certbot
}


