#!/bin/bash -x

# Takes one argument!! The name of the new instance (MUST BE UNIQUE)

# new server with:
# * image -> ubuntu 16.04 amd65
# * flavor -> m1.tiny
# * key -> managerkey
echo ">> Creating instance $1"
openstack server create \
    --image af832c2e-2368-4e87-9f0e-196a4e82c70c \
    --flavor 0a4b6072-3170-447a-8ac1-89562fd1c042 \
    --key-name managerkey \
    $1

# Determine IP of new instance. Keep polling until instance is ready to give IP
echo ">> Waiting for new instance to receive IP"
while [[ -z $INSTANCE_IP ]]; do
    echo ">>> Polling for IP"

    # try and fetch IP of new instance
    INSTANCE_IP=$(openstack server show $1 | awk 'FNR == 13 {print $4}' | awk -F'=' '{print $2}' | awk -F',' '{print $1}')
done

# remove hashed key-entries for (possibly not) new IP
# TO AVOID: weird "WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!" messages
ssh-keygen -R $INSTANCE_IP

# output given IP
echo ">>> IP is: $INSTANCE_IP"

# Poll until new instance is ready for connection. 
echo ">> Waiting for new instance to be ready to receive work... (shouldn't take longer than 2 minutes)"
until ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "echo 'Connected! (sent from new instance)'"; do
    echo ">>> Not ready yet... (sleeping 5 seconds)"
    sleep 5
done

# scp docker install script to new machine and do the install
echo ">> Installing docker on new instance"
scp ./dockerInstall.sh ubuntu@$INSTANCE_IP:
ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo chmod +x dockerInstall.sh"
ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "./dockerInstall.sh"




# SCP over bookface repo?
scp -r ./bookfaceimage ubuntu@$INSTANCE_IP:
# build containers?
ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo docker build -t bookfaceimage bookfaceimage"


# start running containers?
ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo docker run --restart always --name 01 -d -p 32769:80 bookfaceimage"
# fetch IP of containers?
#ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo docker ps" | grep 01
#ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo docker ps" | grep 01 | awk '{print $12}' | awk -F':' '{print $2}' | awk -F'-' '{print $1}'

# start running containers?
ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo docker run --restart always --name 02 -d -p 32768:80 bookfaceimage"
# fetch IP of containers?
#ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo docker ps" | grep 02 | awk '{print $12}' | awk -F':' '{print $2}' | awk -F'-' '{print $1}'

# start running containers?
ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo docker run --restart always --name 03 -d -p 32767:80 bookfaceimage"
# fetch IP of containers?
#ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo docker ps" | grep 02 | awk '{print $12}' | awk -F':' '{print $2}' | awk -F'-' '{print $1}'

# start running containers?
ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo docker run --restart always --name 04 -d -p 32766:80 bookfaceimage"
# fetch IP of containers?
#ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo docker ps" | grep 02 | awk '{print $12}' | awk -F':' '{print $2}' | awk -F'-' '{print $1}'
