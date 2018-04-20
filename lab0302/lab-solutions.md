# Lab solutions for 03-02

## 1

### 1

The upper 5% percentile tells us that there are rarely 27000 or more users.

### 2

We can see that in the beginning there were regularly around 13000 users, while at the end there were regularly 20000 users

### 3

We can see how likely / unlikely it is that we will have X amount of players. Buying hardware to support 40000 players might not be smart when it only happens 1% of the time.

## 2

The script is in this directory with the name `log_incomming_connections.sh`. It looks like this:

```
#!/bin/bash

# curl incomming connections
CURRCONN=$(curl -su someuser:password "http://10.212.136.82:1936/;csv" | grep FRONTEND | head -1 | awk -F',' '{print $5}')

# determine unixtime
UNIXTIME=$(date +%s)

# echo time,connections
echo "$UNIXTIME,$CURRCONN"
```
