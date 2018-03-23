# Solutions to lab 03-16

## 1

* Went out of production using our "mis en plase" script from lab0309
* Renamed our db1 to db1_old
* Made 3 new VMs using our bashrc function (db1, db2 and db3)
* Added entries in each of their `/etc/hosts` files to make name-lookup possible between them

## 2

Prepared the new VMs for database clustering by following Kyrres slides.

* Installed MariaDB on the three VMs by following this website: <https://downloads.mariadb.org/mariadb/repositories/#mirror=tripleit&distro=Ubuntu&distro_release=xenial--ubuntu_xenial&version=10.2>

        sudo apt-get -y install software-properties-common
        sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
        sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mariadb.mirror.triple-it.nl/repo/10.2/ubuntu xenial main'

        sudo apt -y update
        sudo apt -y upgrade
        sudo apt -y install mariadb-server

    Chose password "dynamitt" for all of the installations.

* Made new conf file `/etc/mysql/conf.d/cluster.cnf` that looks like this (Note that the  wsrep_node_address has it's value set based on which machine we're configuring):

        [mysqld]
        # Cluster node configurations
        wsrep_cluster_address="gcomm://db1,db2,db3"
        # Make sure this is corresponds to hostname:
        wsrep_node_address="db1|db2|db3"
        innodb_buffer_pool_size=600M
        # Mandatory settings to enable Galera
        wsrep_on=ON
        wsrep_provider=/usr/lib/galera/libgalera_smm.so
        binlog_format=ROW
        default-storage-engine=InnoDB
        innodb_autoinc_lock_mode=2
        innodb_doublewrite=1
        query_cache_size=0
        bind-address=0.0.0.0
        # Galera synchronisation configuration
        wsrep_sst_method=rsync

* Started db1 in "bootstrap" mode:
    * Stopped mysql
    * Waited for it to be finished stopping
    * `galera_new_cluster`
    * (think we did service mysql start here)
* Stopped and started mysql in db2 and db3
* Stopped and started db1 in normal mode

**NOTE**: We had a ton of trouble getting this to work.

* Added bookface database and user as per "lab0126"
* Loaded database from old db1 by doing:
    * Dumped old db1 into file.
    * Scp'd over file to new db1 (by adding to authorized keys)
    * Loaded dump by logging into mysql as root, creating bookfacedb, using it and doing `source <thefile>`
* Tested it by spinning up new www VM, and pointing it to new db1
