# Lab solutions for 02-23

## 1

### Determined size of database

Determined size of database with the command `sudo du -h /var/lib/mysql`. Gave output:

```
220K    /var/lib/mysql/performance_schema
27M /var/lib/mysql/bookfacedb
1.1M    /var/lib/mysql/mysql
200M    /var/lib/mysql
```

From this we determine that a memcache of size 256 is realistic.

### Made new instance for memcache

Used our osnew function to make a new tiny instance called "cache".

Installed memcache with the command `apt-get install memcached`. Edited `etc/memcached.conf` to listen to 0.0.0.0 and use 256 for caching. Restarted with `service memcached restart`.

## 2

Added memcache support to www3 with `apt-get install php-memcache libmemcached11 libmemcache-dev`. Restarted apache2.

Enabled memcache support in bookface by adding these three lines in `config.php`:

```
$memcache_enabled = 1;
$memcache_enabled_pictures = 1;
$memcache_server = "10.10.0.187";
```

## 3

*Munin has not yet been covered, so we'll wait with installing it*.

## 4

Yes you can choose to not use memcache by setting a GET paramter

## 5

Stopped memcahced. The site still works fine.

## 6

Turned off image support by altering the config file. Tried measuring the speed with the magic command (from stackoverflow) `curl -Lo /dev/null -skw "\ntime_connect: %{time_connect}s\ntime_namelookup: %{time_namelookup}s\ntime_pretransfer: %{time_pretransfer}\ntime_starttransfer: %{time_starttransfer}s\ntime_redirect: %{time_redirect}s\ntime_total: %{time_total}s\n\n"  10.212.136.167` 

We saw no real difference..

## 7

With our current setup with would be more hassle than it's worth. When we eventually transition to a Docker Swarm solution we'll probably use a memcache container.
