#!/bin/bash

# Takes one argument!! The name of the new instance

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

# sleep 120 seconds, print output while doing so
echo ">> Sleeping 120 seconds while instance is spinning up"
for i in `seq 1 120`; do
    echo ">> $i"
    sleep 1
done 

# determine ip of new machine
INSTANCE_IP=$(openstack server show $1 | awk 'FNR == 13 {print $4}' | awk -F'=' '{print $2}' | awk -F',' '{print $1}')

# output if it's working
echo ">> Trying to connect...."
ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "echo 'Connected! (sent from new instance)'"


# scp docker install script to new machine and do the install
echo ">> Installing docker on new instance"
scp dockerInstall.sh ubuntu@$INSTANCE_IP:
ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "sudo chmod +x dockerInstall.sh"
ssh -o "StrictHostKeyChecking no" -t ubuntu@$INSTANCE_IP "./dockerInstall.sh"
