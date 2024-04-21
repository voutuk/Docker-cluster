#!/bin/bash

wget -qO- https://raw.githubusercontent.com/voutuk/file/main/swap.sh | sudo bash
wget -qO- https://raw.githubusercontent.com/voutuk/file/main/docker.sh | sudo bash

docker swarm init
docker stack deploy -c docker-compose.yml global