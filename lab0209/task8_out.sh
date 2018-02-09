#!/bin/bash -x

IP_ADDR=$(openstack server show balancer | grep addresses | awk {'print $5'})
#echo $IP_ADDR

openstack ip floating add $IP_ADDR wwwplaceholder
