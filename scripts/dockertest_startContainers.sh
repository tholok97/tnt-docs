#!/bin/bash -x

# Clean up any containers left from previous stuff (to avoid cluttering)
docker rm -f $(docker ps -qa)

# build the image (in case we changed anything since last)
docker build -t wwwbookfaceimage /home/ubuntu/bookface


# Spin up containers with 
# * hard-coded IPs (so haproxy knows who they are)
# * restart always, so they come up if they're turned off for any reason
# * www bound to local www


# Spin up first container
docker run \
    -d \
    -p 32774:80 \
    --name "wwwbookfacecontainer01" \
    --restart always \
    -v /home/ubuntu/bookface/code:/var/www/html \
    wwwbookfaceimage

# spin up second container
docker run \
    -d \
    -p 32775:80 \
    --name "wwwbookfacecontainer02" \
    --restart always \
    -v /home/ubuntu/bookface/code:/var/www/html \
    wwwbookfaceimage

