# Solutions to lab 04-27

## 1

* Used our bash functions to make three new micro VMs called consul1, consul2 and consul3.
* Installed consul on the three new machines using this snippet from the lecture (had to install unzipped first):

        apt-get install -y unzip
        wget https://releases.hashicorp.com/consul/1.0.7/consul_1.0.7_linux_amd64.zip
        unzip consul_1.0.7_linux_amd64.zip
        mv consul /usr/local/bin/
        mkdir /opt/consul

* Set up cluster as described in the lecture:
    * Found old DNS with `cat /etc/resolv.conf`. 
    * In consul 1:
        * `screen -S consul`
        * `consul agent -server -bootstrap -data-dir /opt/consul`
    * In consul 2 and 3:
        * `screen -S consul`
        * `consul agent -server -data-dir /opt/consul -client 0.0.0.0 -dns-port 53 -recursor <DNS-IP>`
    * In consul 1:
        * Without stopping screen: `consul join <CONSUL2-IP> <CONSUL3-IP>`
        * Then, stop consul screen
        * Now: `consul agent -ui -server -data-dir /opt/consul -client 0.0.0.0 -dns-port 53 -recursor <DNS-IP>`
* We then checked out the dashboard by doing `curl $(osipof consul1):8500/ui/`. Got lots of HTML output
* We then added a floating ip to consul 1:
    * `os ip floating create ntnu-internal`
    * `os ip floating add <NEW-IP> consul1`
    * (Added port 8500 ingress to allowed in security groups)

## 2

Did as described in slides.

**NOTE:** command from slides was changed to: `consul agent -data-dir /opt/consul -join CONSUL1-IP --config-dir /etc/consul/ services --enable-script-check`

## 3

### To get this working we first redeployed our docker swarm.

### TBD
