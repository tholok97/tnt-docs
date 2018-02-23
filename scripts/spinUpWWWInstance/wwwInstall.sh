#!/bin/bash

apt-get -y update && apt-get -y upgrade
apt-get -y install apache2 libapache2-mod-php php-mysql
apt-get -y install php-memcache libmemcached11 libmemcache-dev
rm -rf /var/www/html/index.html
service apache2 restart
