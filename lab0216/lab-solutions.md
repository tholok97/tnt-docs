# Lab solutions 02-16

## 1

Made bashrc function that spins up new instance with given name. Used this function to spin up new instance with name "backup".

Generated key in "db1" with `ssh-keygen`. Manually copied generated public key from db1 to authorized keys in backup.

Check that it works -> it does!

## 2

> Useful commands from Kyrre: `sfdisk -l`, `date`, `mkfs`, formattere disk: `<filsystem> /dev/vdb`

* Made volume "backupVolume" with size 5G and attached it to backup instance (device `/dev/backups`).
* formatted backup to mkfs.ext4 vdb with `mkfs.ext4 /dev/mkfs.ext4`
* Made backups directory and mounted with `mount /dev/vdb /backups`

**TODO**: Mount on startup

## 3

### Stuff needed for a "full" backup of mysql database:

mysqldump (`mysqldump --opt --master-data=2 --flush-logs
--all-databases > backup.sql`)

```
/var/log/syslog
/var/log/mysql/*
/etc/logrotate.d/mysql-server
```

## 4

Script can be found in this directory with the name "db1_fullBackup.sh"

## 5

1. What files are being rotated: `/var/log/mysql/mysql.log /var/log/mysql/mysql-slow.log /var/log/mysql/mariadb-slow.log /var/log/mysql/error.log`
2. When are the files rotated: Once a week. Daily backup is taken, and 7 archieved logs are kept.
3. How many rotated files we have: 7

## 6

*TBA*

## 7

As per right now we can't because we're missing keys going that way. If we added the key, we would also have to add a database user with the right privileges.

## 8

### Taking backup directly from backup instance

#### Advantages:

* With multiple database-servers, the script will only live on one server
* The backup server decided when it wants to take backup

#### Disadvantage:

* Encryption not for free
* Database might not be ready for backup

## 9

The command for starting a new binary log file is `mysqladmin flush-logs`

## 10

From: <https://dev.mysql.com/doc/refman/5.7/en/flush.html>

If binary logging is enabled, the sequence number of the binary log file is incremented by one relative to the previous file. If relay logging is enabled, the sequence number of the relay log file is incremented by one relative to the previous file.

## 11

Do not stop at the end of requested binary log from a MySQL server, but rather continue printing to end of last binary log

## 12

`mysqlbinlog --start-datetime="2018-02-14 09:00:00" --stop-datetime="2018-02-15 23:59:59" `

## 13

## 14
Backup Policy:
* A full backup is taken every monday midnight.
* Incremental backups are taken every days at midnight, except monday midnights.
* If the bandwidth is too low at monday midnights, an incremental backup is taken instead of a full backup.

