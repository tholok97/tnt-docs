# Solutions to lab tasks 01-19

## 1 

Done

## 2

Done. Important to connect the floating IP to the internal network.

## 3 

Installed apache with:

        apt-get update
        apt-get install apache2

    added PHP and MySQL support with:

        apt-get install libapache2-mod-php php-mysql
        apt-get install mysql-client

## 4 

Tested it from manager with `wget -q -O - http://<manager-ip>/`

## 5 

Installed haproxy with:

        sudo add-apt-repository -y ppa:vbernat/haproxy-1.8
        apt-get update
        apt-get install haproxy socat

configured haproxy by adding the following to /etc/haproxy/haproxy.cfg

        frontend bookface
            bind *:80
            mode http
            default_backend nodes

        backend nodes
            mode http
            balance roundrobin
            server www1 10.10.0.123:80 check
            server www2 10.10.0.134:80 check

        listen stats
            bind *:1936
            stats enable
            stats uri /
            stats hide-version
            stats auth someuser:password

**Note:** had to restart haproxy for it to work. Works with both the private and floating IPs (?)

## 6 

Sent the info. Chose the group name "TnT"

## 7 
