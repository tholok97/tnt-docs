#!/bin/bash

# Sets the date (variable).
dato=$(date +%Y_%m_%d)

# Creates folders in the backup VM.
ssh -t ubuntu@10.10.1.81 "mkdir -p /backups/$dato/var/log \
    && mkdir -p /backups/$dato/var/log/mysql \
    && mkdir -p /backups/$dato/etc/logrotate.d/"

# Secure-copies over syslog and mysql (bin) logfiles from db1 to backup VM.
scp -r /var/log/syslog ubuntu@10.10.1.81:/backups/$dato/var/log/syslog
scp -r /var/log/mysql ubuntu@10.10.1.81:/backups/$dato/var/log/
scp -r /etc/logrotate.d/mysql-server ubuntu@10.10.1.81:/backups/$dato/etc/logrotate.d/mysql-server

# Creates a mysqldump to a temp file and sends this temp to the backup VM.
sudo mysqldump -pdynamitt --opt --flush-logs --all-databases > mysqldump_$dato.tmp
scp -r mysqldump_$dato.tmp ubuntu@10.10.1.81:/backups/$dato/mysqldump.sql
