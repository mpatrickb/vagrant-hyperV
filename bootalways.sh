#!/usr/bin/env bash

#cd /var/www/
#php bin/console server:start
#php bin/console cache:clear --env=dev
#php bin/console cache:clear --env=prod

ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
echo $ip4 >> /vagrant/ipaddress