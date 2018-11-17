# Solutions to lab 04-06

## 1
See the python source code down below.

## 2
The backup_plan.conf file is not very eligible to dynamic systems because new servers will
have new IP-adresses. Also a new pair of SSH- keys are required.

One possible solution is to have each new server sending their internal IP-address and their SSH-key
over scp to the backup server so they can be stored in the configuration file.

Another, possible solution that supports dynamic thinking better, is to have one large Docker virtual machine
that runs most of the servers as docker containers, especially those containers (virtual machines) that should be backuped.
Then the config file on the backup server only need the IP-adress of the Docker virtual machine and no SSH- keys needed.
The config file can be reorganized to store backup data based on docker instances, not virtual machines.
