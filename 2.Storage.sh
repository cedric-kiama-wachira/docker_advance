#!/bin/bash
 ls -l /var/lib/docker
total 44
drwx--x--x.  4 root root 4096 Oct  6 23:19 buildkit
drwx--x---.  3 root root 4096 Nov  1 20:50 containers
-rw-------.  1 root root   36 Oct  6 23:19 engine-id
drwx------.  3 root root 4096 Oct  6 23:19 image
drwxr-x---.  3 root root 4096 Oct  6 23:19 network
drwx--x---. 13 root root 4096 Nov  1 20:50 overlay2
drwx------.  4 root root 4096 Oct  6 23:19 plugins
drwx------.  2 root root 4096 Nov  1 20:44 runtimes
drwx------.  2 root root 4096 Oct  6 23:19 swarm
drwx------.  2 root root 4096 Nov  1 20:48 tmp
drwx-----x.  3 root root 4096 Nov  1 20:44 volume


docker build --mount type=bind, source=/etc/OS_dir, target=/etc/Container_dir

# Storage Drivers
AUFS
ZFS
BTRFS
Device Mapper
Overlay
Overlay2

docker history <image_ID>
docker system df

docker system df -v

docker run -d --name mysql-db  -e MYSQL_ROOT_PASSWORD=db_pass123 mysql

docker run -d --name mysql-db  -e MYSQL_ROOT_PASSWORD=db_pass123 mysql'


docker run -v /opt/data:/var/lib/mysql -d --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 mysql

git clone https://github.com/dockersamples/example-voting-app.git

cd  example-voting-app.git
docker compose version
docker compose up

