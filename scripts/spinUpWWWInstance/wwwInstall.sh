#!/bin/bash

apt-get -y update
apt-get -y install apache2 libapache2-mod-php php-mysql
rm -rf /var/www/html/index.html
service apache2 restart
