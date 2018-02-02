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
