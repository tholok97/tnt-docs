# Solutions for lab 04-20

## 1

Ate pizza.

# Notes about migrating to new manager VM

We had problems with our manager VM running out of space. Instead of fiddling with upgrading it, we decided to migrate to an entirely new VM. We stored ssh keys and vimrc away and deleted old manager. New manager only needed to add the ssh keys and vimrc and clone down our repo. A bit of fiddling was necessary to make bashrc load correctly.

## TBD

* As the old manager was leader in a docker swarm, we need to find a new leader VM.
