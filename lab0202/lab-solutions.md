# Solutions to lab0202

# 1

Made new instance `dockertest`

* ubuntu 16.04 amd64
* medium size
* manager key


## Installing docker ce

Used this installation guide to install Docker CE: <https://docs.docker.com/install/linux/docker-ce/ubuntu/>

        sudo apt-get update

        sudo apt-get install \
            apt-transport-https \
            ca-certificates \
            curl \
            software-properties-common

        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

        sudo apt-key fingerprint 0EBFCD88

        sudo add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
            stable"

        sudo apt-get update

        sudo apt-get install docker-ce

        sudo docker run hello-world

Made it into a script that can be found in this directory.

# 2

## Basic www container

Made container with `docker run --name wwwtest2 -i -t ubuntu:16.04 /bin/bash`

Followed the instructions on installing bookface from previous lab (**NOTE**: Replaced all occurances of php5 with php).

Committed changes with `docker commit -m "somemessage" wwwtest2 wwwtest3`

Ran new container with same command as above, but exposed port 80 with `-p 80:80`

# 6

Lists all containers (both running and stopped)

# 7

`docker rm`

# 8

`--name` ved `docker run`, `docker rename <OLD> <NEW>`

# 9

According to our tests. no.

# 10

According to our tests: no.

# 11

*TBA*

# 12

Yes we could do this. This means we could easily spin up more docker-enabled VMs to run our containers on.
