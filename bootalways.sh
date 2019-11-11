#!/usr/bin/env bash

# ----------
# SETTING
# ----------

# ----------
# PHP VERSION
# unmark the version you want
# ----------
# a2dismod php7.*; a2enmod php7.2; service apache2 restart
a2dismod php7.*; a2enmod php7.3; service apache2 restart
# a2dismod php7.*; a2enmod php7.4; service apache2 restart


# ----------
# SYMFONY
# ----------
#cd /var/www/
#php bin/console server:start
#php bin/console cache:clear --env=dev
#php bin/console cache:clear --env=prod

ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
echo $ip4 >> /vagrant/ipaddress