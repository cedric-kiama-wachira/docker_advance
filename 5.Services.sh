#!/bin/bash

# The Ochestrator in action
# From the master node
docker create service --replica=3 --name apache_srv apache2

docker create service --mode global my_log_monitor

# Add my apache service to a new docker instance
docker service --update-replica=4 apache_srv 

# Add a 4th node and make it a worker node 4
DONE 

# Creating a service from the first master node
docker login
# Log in with your Docker ID or email address to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com/ to create one.
# You can log in with your password or a Personal Access Token (PAT). Using a limited-scope PAT grants better security and is required for organizations using SSO. Learn more at https://docs.docker.com/go/access-tokens/

Username: cedric.kiama@gmail.com
Password: 
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

# Login Succeeded

docker pull nginx

docker service  create --name my_nginx_web_srv nginx

66wqjedetr16a8jzoaw3ob6wq
overall progress: 1 out of 1 tasks 
1/1: running   [==================================================>] 
verify: Service converged

docker service ls
ID             NAME               MODE         REPLICAS   IMAGE          PORTS
66wqjedetr16   my_nginx_web_srv   replicated   1/1        nginx:latest  

docker service ps 66wqjedetr16
ID             NAME                 IMAGE          NODE      DESIRED STATE   CURRENT STATE           ERROR     PORTS
8xz03xqyi3p2   my_nginx_web_srv.1   nginx:latest   work2     Running         Running 4 minutes ago

docker service ls
ID             NAME               MODE         REPLICAS   IMAGE          PORTS
66wqjedetr16   my_nginx_web_srv   replicated   1/1        nginx:latest

docker service update 66wqjedetr16 --publish-add 5000:80

# Cleanup from the master node and create a replica set

docker service ls
ID             NAME               MODE         REPLICAS   IMAGE          PORTS
66wqjedetr16   my_nginx_web_srv   replicated   1/1        nginx:latest   *:5000->80/tcp

docker service rm 66wqjedetr16

docker service create --replicas 3 --name my_nginx_web_srv nginx

yp776c774m6yuzzmgu577klg6
overall progress: 3 out of 3 tasks 
1/3: running   [==================================================>] 
2/3: running   [==================================================>] 
3/3: running   [==================================================>] 
verify: Service converged 

docker service ls
ID             NAME               MODE         REPLICAS   IMAGE          PORTS
yp776c774m6y   my_nginx_web_srv   replicated   3/3        nginx:latest

 my_nginx_web_srv   replicated   3/3        nginx:latest   

docker service ps yp776c774m6y

ID             NAME                 IMAGE          NODE      DESIRED STATE   CURRENT STATE                ERROR     PORTS
lo3ii9k4upma   my_nginx_web_srv.1   nginx:latest   master2   Running         Running about a minute ago             
o82e9jhbk068   my_nginx_web_srv.2   nginx:latest   master1   Running         Running about a minute ago             
xf6o5mccpkxa   my_nginx_web_srv.3   nginx:latest   work4     Running         Running about a minute ago


# To let the manager one only do manage work and not have any container running on it
docker node update --availability drain master1

docker service ps yp776c774m6y
ID             NAME                     IMAGE          NODE      DESIRED STATE   CURRENT STATE            ERROR     PORTS
lo3ii9k4upma   my_nginx_web_srv.1       nginx:latest   master2   Running         Running 19 minutes ago             
o7mhf3fc88jp   my_nginx_web_srv.2       nginx:latest   work3     Running         Running 8 seconds ago              
o82e9jhbk068    \_ my_nginx_web_srv.2   nginx:latest   master1   Shutdown        Shutdown 8 seconds ago             
xf6o5mccpkxa   my_nginx_web_srv.3       nginx:latest   work4     Running         Running 19 minutes ago

# Example Exercise
docker swarm init --advertise-addr 192.16.122.35
docker service  create --replicas 3 -p 8083:8080 -e APP_COLOR=pink --name simple-web-app kodekloud/webapp-color
docker service update simple-web-app --replicas 4




