#!/bin/bash

# Creating an alternative private registry to public registry docker hub
docker run -d -p 5000:5000 --restart always --name registry registry:2

# Now, use it from within Docker:
docker pull ubuntu
docker tag ubuntu localhost:5000/ubuntu
docker push localhost:5000/ubuntu

docker exec -it registry /bin/sh


