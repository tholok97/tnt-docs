#!/bin/bash

#This is a bash script that automates the startup process of servers that
#are shut down. This does not affect servers that should stay shut down.

#Array of servers that SHOULD be on shutdown.
#(This script WILL NOT turn on these servers).
idleServers=("docker_swam_worker2" 
             "docker_swarm_worker" 
             "wwwplaceholder"
            )


#Internal Field Separator: In a for-loop, each line is treated as one iteration.
IFS=$'\n'


echo "Checking status..."
for server in $(openstack server list); do
    name=$(echo $server | awk {'print $4'})
    stat=$(echo $server | awk {'print $6'})

    #If the current server in the loop is in the idleServers array,
    #nothing will happens.
    if [[ "${idleServers[@]}" =~ "${name}" ]]; then
            : # no-op #
    #Else if this is a production server, it will go on and check
    #if the status is on SHUTOFF. It will then restart the server.
    elif [[ $stat = "SHUTOFF"  ]]; then
        echo "$name is shut down! Restarting...." >> testlog.txt
        openstack server start $name
    fi
done