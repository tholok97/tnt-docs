#1/bin/bash

ssh -t ubuntu@10.10.0.123 "sudo service apache2 stop"
ssh -t ubuntu@10.10.0.134 "sudo service apache2 stop"
