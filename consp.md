# Create docker cluster 21.04

```bash
docker login -u voutuk
docker commit 510f466fa005 tesst:main
docker tag tesst:main voutuk/corp-site:main
docker push voutuk/corp-site:main
```
docker run -v "$(pwd)":/usr/src/app voutuk/corp-site:main
docker run voutuk/corp-site:main

`docker swarm init --advertise-addr <my ip>`
`docker swarm leave`
`docker node ls`

docker swarm init
docker stack deploy -c docker-compose.yml global --detach=false


docker swarm init --advertise-addr  192.168.1.56
docker swarm join-token manager   глянути токен і команду мастера

docker swarm join-token worker    глянути токен і команду воркера

docker node ls

docker service create --name test1 -p 8080:80 --mode global francois/apache-hostname

docker servece ls

docker rm -f id