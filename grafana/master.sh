#!/bin/bash

wget -qO- https://raw.githubusercontent.com/voutuk/file/main/swap.sh | sudo bash
wget -qO- https://raw.githubusercontent.com/voutuk/file/main/docker.sh | sudo bash

git clone https://github.com/voutuk/PAG

# docker swarm init
# cd docker
# docker stack deploy -c docker-compoose.yml global --detach=false
