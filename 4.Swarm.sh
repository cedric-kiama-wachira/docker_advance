#!/bin/bash

# Master Node 1 and Node 2
ssh  -o "IdentitiesOnly yes" -i "docker-swarm-key.pem" ubuntu@ec2-3-29-168-243.me-central-1.compute.amazonaws.com
ssh  -o "IdentitiesOnly yes" -i "docker-swarm-key.pem" ubuntu@ec2-51-112-10-78.me-central-1.compute.amazonaws.com
# Worker Node 1,2,3 and 4
ssh  -o "IdentitiesOnly yes" -i "docker-swarm-key.pem" ubuntu@ec2-51-112-16-103.me-central-1.compute.amazonaws.com
ssh  -o "IdentitiesOnly yes" -i "docker-swarm-key.pem" ubuntu@ec2-3-28-115-32.me-central-1.compute.amazonaws.com
ssh  -o "IdentitiesOnly yes" -i "docker-swarm-key.pem" ubuntu@ec2-51-112-9-140.me-central-1.compute.amazonaws.com
ssh  -o "IdentitiesOnly yes" -i "docker-swarm-key.pem" ubuntu@ec2-3-29-190-232.me-central-1.compute.amazonaws.com

vi /etc/hosts
3.29.168.243 master1
51.112.10.78 master2
51.112.16.103 work1
3.28.115.32 work2
51.112.9.140 work3

# On the master1
docker swarm init

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-5yfwgosq2mvqrb9w3n8dfbpzbhhmae370n030z7d6dy32s89nb-63tjsa5b4s9itucwis77zhk00 172.31.3.82:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.


# On the Worker Nodes
    docker swarm join --token SWMTKN-1-5yfwgosq2mvqrb9w3n8dfbpzbhhmae370n030z7d6dy32s89nb-63tjsa5b4s9itucwis77zhk00 3.29.168.243:2377

# Back on the master node 
docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
myyy6gtodi1abnkwm6ls16rua *   master     Ready     Active         Leader           24.0.7
r5ya8mqgy8x09zciaczw2ebgz     work1      Ready     Active                          24.0.7
9ro4wwpiigx26szrzcyvloo6e     work2      Ready     Active                          24.0.7
lm1tjs72l58881u9jptfvb73e     work3      Ready     Active                          24.0.7

# Nodes leaving the swarm
docker swarm leave
Node left the swarm.

# Back to the master node
docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
myyy6gtodi1abnkwm6ls16rua *   master     Ready     Active         Leader           24.0.7
r5ya8mqgy8x09zciaczw2ebgz     work1      Down      Active                          24.0.7
9ro4wwpiigx26szrzcyvloo6e     work2      Down      Active                          24.0.7
lm1tjs72l58881u9jptfvb73e     work3      Down      Active                          24.0.7


# Remove the nodes from the list
docker node rm r5ya8mqgy8x09zciaczw2ebgz 9ro4wwpiigx26szrzcyvloo6e lm1tjs72l58881u9jptfvb73e
r5ya8mqgy8x09zciaczw2ebgz
9ro4wwpiigx26szrzcyvloo6e
lm1tjs72l58881u9jptfvb73e

docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
myyy6gtodi1abnkwm6ls16rua *   master     Ready     Active         Leader           24.0.7

# Adding a second master node in the swarm issue below command from the first master node
docker swarm join-token manager
To add a manager to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-5yfwgosq2mvqrb9w3n8dfbpzbhhmae370n030z7d6dy32s89nb-ci31svca0gkbygyb4nhabehhp 3.29.168.243:2377

docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
myyy6gtodi1abnkwm6ls16rua *   master1    Ready     Active         Leader           24.0.7
6n8j7sop5riiobmyr3zxujscc     master2    Ready     Active         Reachable        24.0.7

docker swarm join-token worker

swarm join-token worker
To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-5yfwgosq2mvqrb9w3n8dfbpzbhhmae370n030z7d6dy32s89nb-63tjsa5b4s9itucwis77zhk00 3.29.168.243:2377

docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
myyy6gtodi1abnkwm6ls16rua *   master1    Ready     Active         Leader           24.0.7
6n8j7sop5riiobmyr3zxujscc     master2    Ready     Active         Reachable        24.0.7
qtiu5gzxrus7gw75zeaiskcys     work1      Ready     Active                          24.0.7
5ektfbznlod5p59unkvti2at1     work2      Ready     Active                          24.0.7
xt5r0hirb2nq2mw06x5g2a8j8     work3      Ready     Active                          24.0.7

# Promote work node 3 to be a master make sure the port 2377 is open on the security group
# Then from the master node
docker node promote work3
Node work3 promoted to a manager in the swarm.

docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
myyy6gtodi1abnkwm6ls16rua *   master1    Ready     Active         Leader           24.0.7
6n8j7sop5riiobmyr3zxujscc     master2    Ready     Active         Reachable        24.0.7
qtiu5gzxrus7gw75zeaiskcys     work1      Ready     Active                          24.0.7
5ektfbznlod5p59unkvti2at1     work2      Ready     Active                          24.0.7
xt5r0hirb2nq2mw06x5g2a8j8     work3      Ready     Active         Reachable        24.0.7

# Simulating a cluster down time and bringing it back with recreating the cluster
docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
myyy6gtodi1abnkwm6ls16rua *   master1    Ready     Active         Leader           24.0.7
6n8j7sop5riiobmyr3zxujscc     master2    Ready     Active         Unreachable      24.0.7
qtiu5gzxrus7gw75zeaiskcys     work1      Ready     Active                          24.0.7
5ektfbznlod5p59unkvti2at1     work2      Ready     Active                          24.0.7
xt5r0hirb2nq2mw06x5g2a8j8     work3      Down      Active         Unreachable      24.0.7

docker node ls
Error response from daemon: rpc error: code = DeadlineExceeded desc = context deadline exceeded

# On the master node 1
docker swarm init --force-new-cluster --advertise-addr 3.29.168.243
Swarm initialized: current node (myyy6gtodi1abnkwm6ls16rua) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-5yfwgosq2mvqrb9w3n8dfbpzbhhmae370n030z7d6dy32s89nb-63tjsa5b4s9itucwis77zhk00 3.29.168.243:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

