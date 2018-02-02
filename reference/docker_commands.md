# Some useful docker commands

## running

* `docker run` to run a new container
    * `--name` give it a name
    * `--network <network>` specifiy the network (default is bridge)
    * `-i` to run interactively
    * `-d` run detached
    * `-t` used together with `-i`... Does something with something called a pseudo tty
* `docker attach` attaches to a running container
* Press `CTRL-p CTRL-q` to exit a running container, but leave it running

## Networking

`docker network ls` show all networks.
`docker netork inspect <network>` to inspect a network

## Stop and remove all containers

```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```
