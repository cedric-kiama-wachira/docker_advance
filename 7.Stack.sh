#!/bin/bash

git clone https://github.com/dockersamples/example-voting-app.git


docker stack deploy voting-app-stack --compose-file docker-stack.yml
Creating network voting-app-stack_frontend
Creating network voting-app-stack_backend
Creating service voting-app-stack_redis
Creating service voting-app-stack_db
Creating service voting-app-stack_vote
Creating service voting-app-stack_result
Creating service voting-app-stack_worker

docker service ls
ID             NAME                      MODE         REPLICAS   IMAGE                                          PORTS
yp776c774m6y   my_nginx_web_srv          replicated   3/3        nginx:latest                                   
3xwq5q21pv0w   voting-app-stack_db       replicated   1/1        postgres:15-alpine                             
w2eq4xebqmuw   voting-app-stack_redis    replicated   1/1        redis:alpine                                   
bgamj8rp1pz3   voting-app-stack_result   replicated   1/1        dockersamples/examplevotingapp_result:latest   *:5001->80/tcp
6ml8bmngohu0   voting-app-stack_vote     replicated   2/2        dockersamples/examplevotingapp_vote:latest     *:5000->80/tcp
7myvjdp0kaax   voting-app-stack_worker   replicated   2/2        dockersamples/examplevotingapp_worker:latest   

docker service ps voting-app-stack_worker
ID             NAME                        IMAGE                                          NODE      DESIRED STATE   CURRENT STATE           ERROR     PORTS
7y8ocws6ojqg   voting-app-stack_worker.1   dockersamples/examplevotingapp_worker:latest   work1     Running         Running 4 minutes ago             
po7ialqnia6g   voting-app-stack_worker.2   dockersamples/examplevotingapp_worker:latest   work3     Running         Running 4 minutes ago 

# Docker Visualizer - run below command from master node

docker run -it -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock dockersamples/visualizer
