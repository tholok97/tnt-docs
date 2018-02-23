#!/bin/bash -x

echo ">> Creating instance $1"
openstack server create \
    --image af832c2e-2368-4e87-9f0e-196a4e82c70c \
    --flavor 7d7f1dfe-9af0-48ff-9ecf-5b501a20b4cb \
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



# READY FOR WORK

#INSTANCE_IP=10.10.0.142



# scp over install script
scp wwwInstall.sh ubuntu@$INSTANCE_IP:

# chmod it
ssh -t ubuntu@$INSTANCE_IP "sudo chmod +x ./wwwInstall.sh"

# run script
ssh -t ubuntu@$INSTANCE_IP "sudo ./wwwInstall.sh"

# make html owned by ubuntu
ssh -t ubuntu@$INSTANCE_IP "sudo chown -R ubuntu /var/www/html"

# scp over bookface
scp -r ./bookface/code/* ubuntu@$INSTANCE_IP:/var/www/html


