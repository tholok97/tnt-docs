#!/bin/bash

# curl incomming connections
CURRCONN=$(curl -su someuser:password "http://10.212.136.82:1936/;csv" | grep FRONTEND | head -1 | awk -F',' '{print $5}')

# determine unixtime
UNIXTIME=$(date +%s)

# echo time,connections
echo "$UNIXTIME,$CURRCONN"
