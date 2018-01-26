# Solutions to lab tasks 01-26

## 1

### Made instance with name db1.

* medium size
* ubuntu 16.04 amd64
* manager keypair

### Installed mysql server:

        apt-get update
        apt-get install mysql-server

(chose password "dynamitt")
    
### Configured database. Tested with

        mysqladmin -u root -p version
        mysqladmin -u root -p variables
        mysqlshow -p
        mysqlshow -p mysql

Some useful commands:

        service mysql start|stop
        service mysql status

### Configuring mysql

Config is under `mariadb.conf.d/50-server.cnf`. Opened it and changed the bind-address under `[mysqld]` to 0.0.0.0.

Configured root with new privilidges with `GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION; FLUSH PRIVILEGES;`. (To allow root to connect from manager).

See users with `select * from mysql.user\G`

### Tried connecting from manager

        mysql -h server -u user -p mysql

**NOTE**: had to install a mysql-client on manager

Works!

### Turned on bin logging

..by going to the cnf file and removing the comment from the `log_bin` line under `[mysqld]`

## 2

Created db for bookface with `CREATE DATABASE bookacedb` in mysql

Added bookface user with the command `GRANT SELECT,UPDATE,INSERT,CREATE,DROP,DELETE on bookfacedb.* to 'harry'@'10.10.0.%' identified by 'kaboom';`

Tested that could connect from www1 and www2.

## 3

Followed the instructions on <https://git.cs.hioa.no/kyrre/bookface>.

Gave Kyrre our IP. He set up traffic for us. It's working fine :D
