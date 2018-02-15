#!/bin/bash


#This is a bash script that automates the startup process of servers that
#are shut down. This does not affect servers that should stay shut down.
#Every incident is reported to logfile.txt in the git-repo with timestamp of
#the occurence (YYYY-MM/DD:::hh:mm:ss GMT).
#The logfile needs to be pushed manually to GitHub as of now.

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
    #if the status is on SHUTOFF. It so,the server will restart.
    #An entry will then be appended to the logfile in the git-repo (for both tholok and thetlad)
    elif [[ $stat = "SHUTOFF"  ]]; then
        echo -e "\`$(date +%Y-%m/%d:::%H:%M:%S) GMT --> $name is shut down! Restarting....\`\\n" \
            | tee -a /home/ubuntu/tnt-docs-tholok/reports/logfile.md \
                     /home/ubuntu/tnt-docs-thetlad/reports/logfile.md
        openstack server start $name
    fi
done
