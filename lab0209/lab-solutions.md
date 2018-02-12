# Lab solutions for 0209

## 1

Formed this sql in mysql cli:

        SELECT COUNT(*)
        FROM user

Made it into this bash command: `echo 'SELECT COUNT(*) FROM user' | mysql -u root -pdynamitt bookfacedb`

Made it into a bash function that takes a table as argument

## 2

Script is found in this directory with the name "task2.sh"

## 3

Script is found in this directory with the name "task3.sh"

Couldn't get rid of the ls error message. (Tried sending the output to `/dev/null`)

## 4

A script version is found in this directory with the name "task4.sh". Could easily be turned into an alias by either copying it into .bashrc or making the alias refer to the script.

## 5

Followed the instructions. `openstack server list` works.

## 6

Did that.

## 7

Did that. Apparently adding a floating IP that is bound to another server moves it from one server t the other. 

Yes, it can be useful when updating the entrypoint to the system. (Creating a new balanacer and moving old floating ip to new one)

## 8

Script is found in this directory "task8_in.sh" and "task8_out.sh". They move the floating IP users use to access our website between the balancer and a placeholder server.

## 9

wc prints newline, bytecount and wordcount for each file

## 10

* The first command shows partitions and disk usage
* The second command shows directories sorted after disk usage (ascending)

## 11

* `mkdir /home/ubuntu/supperask` creates a directory named superrask.
* `mount -t tmpfs -o size=20m tmpfs /home/ubuntu/superrask` makes the directory a sticky directory. Meaning that the directory can not be changed by users.
* `chown ubuntu:ubuntu /home/ubuntu/superrask` lets the user ubuntu have permissions to change the sticky directory.
* `umount /home/ubuntu/superrask` reverts the superrask directory back to a normal directory.
