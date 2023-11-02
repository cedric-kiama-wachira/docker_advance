#!/bin/bash

# Default
Bridge is the default network in docker
docker run image_name

# Host
Host uses the host network and everything gets mapped to the network and port
docker run image_name --network=host

# None
The container dont have access to any network or port
docker run image_name --network=none

# overlay
Create a network to be used across the entire swarm

docker network create --driver overlay --subnet 10.0.9.0/24 my-overlay-network

# Create a service and let the containes communicate with each other
docker service create --replicas 2 --netwok my-overlay-network image_name

# Ingress Network is an advance type of overlay network created automatically when creating a service and mapping the port
docker service create  --replicas 3 -p 5000:80 image_name

# Embeded DNS
Docker has a built in dns server running on IP 127.0.0.11
So programmatically instead of using a container IP, we just use the container name.


