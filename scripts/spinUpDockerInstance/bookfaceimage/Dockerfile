FROM ubuntu:16.04
MAINTAINER Thomas Løkkeborg "thomahl@stud.ntnu.no"

# update and install all necessary services
RUN apt-get -y update && apt-get -y install apache2 libapache2-mod-php php-mysql

# remove default apache html index
RUN rm -rf /var/www/html/index.html

# copy in bookface stuff
COPY bookface/code /var/www/html

# ask nicely to expose port 80
EXPOSE 80

# start apache2 by default
CMD /usr/sbin/apache2ctl -D FOREGROUND
