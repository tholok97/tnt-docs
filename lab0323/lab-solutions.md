# Solutions to lab 03-23

## 1
Created two new servers (storage1 and storage2) as micro servers.
Ran `sudo apt update && sudo apt upgrade` on both VMs.
Added the IP-address to storage2 on storage1.
Ran these commands on storage1:
    `gluster peer probe storage2
    gluster volume create gv0 replica 2 storage1:/brick storage2:/brick
    gluster volume start gv0`

Ran status checks on storage1:
    `gluster volume info
    gluster peer status`
It works!

## 2
Installed glusterfs-client on manager with `sudo apt install glusterfs-client`.
Made a new directory on manager root called 'site' with `mkdir /site`

