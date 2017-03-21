### nginx.conf
```sh
user  nginx;
worker_processes  1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {
    upstream bskapp.localdomain {
	least_conn;
        server node1.localdomain;
        server node2.localdomain;
        server node3.localdomain;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://bskapp;
        }
    }

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
}
```

### Dockerfile
```sh
FROM nginx
EXPOSE 80 443
COPY nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]
```

### build.sh
```sh
#!/bin/bash
docker build -t manager.localdomain:5000/bsk/nginx .
docker push     manager.localdomain:5000/bsk/nginx

docker run -d -p 80:80 \
    --name nginx \
    --add-host=manager.localdomain:192.168.122.200 \
    --add-host=bskapp.localdomain:192.168.122.200 \
    --add-host=node1.localdomain:192.168.122.201 \
    --add-host=node2.localdomain:192.168.122.202 \
    --add-host=node3.localdomain:192.168.122.203 \
    manager.localdomain:5000/bsk/nginx
```
