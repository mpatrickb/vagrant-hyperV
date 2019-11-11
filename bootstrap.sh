#!/usr/bin/env bash

apt-get install software-properties-common
add-apt-repository ppa:ondrej/php
apt-get update
apt-get upgrade -y

# unzip is for composer
apt-get install vim unzip  -y

apt-get install apache2 -y
apt-get install mysql-client libmysqlclient-dev -y

# PHP 7.2
apt-get install libapache2-mod-php7.2 php7.2 php7.2-mysql php7.2-sqlite -y
apt-get install php7.2-mbstring php7.2-curl php7.2-intl php7.2-gd php7.2-zip php7.2-bz2 -y
apt-get install php7.2-dom php7.2-xml php7.2-soap -y

# PHP 7.3
apt-get install php7.3 -y
apt-get install php-pear php7.3-curl php7.3-dev php7.3-gd php7.3-mbstring php7.3-zip php7.3-mysql php7.3-xml -y

# PHP 7.4
apt-get install php7.4 -y
apt-get install libapache2-mod-php7.4 php7.4-cli php7.4-mysql php7.4-gd php7.4-imagick php7.4-tidy php7.4-xmlrpc -y

apt-get install --reinstall ca-certificates -y

# install the php xdebug extension (only for dev servers!)
apt-get install php-xdebug -y

# add xdebug settings to php.ini
echo 'xdebug.remote_port=9000' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.remote_port=9000' >> /etc/php/7.3/apache2/php.ini
echo 'xdebug.remote_port=9000' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_enable=true' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.remote_enable=true' >> /etc/php/7.3/apache2/php.ini
echo 'xdebug.remote_enable=true' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_connect_back=true' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.remote_connect_back=true' >> /etc/php/7.3/apache2/php.ini
echo 'xdebug.remote_connect_back=true' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_autostart=on' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.remote_autostart=on' >> /etc/php/7.3/apache2/php.ini
echo 'xdebug.remote_autostart=on' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_host=' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.remote_host=' >> /etc/php/7.3/apache2/php.ini
echo 'xdebug.remote_host=' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.max_nesting_level=1000' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.max_nesting_level=1000' >> /etc/php/7.3/apache2/php.ini
echo 'xdebug.max_nesting_level=1000' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.idekey=PHPSTORM' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.idekey=PHPSTORM' >> /etc/php/7.3/apache2/php.ini
echo 'xdebug.idekey=PHPSTORM' >> /etc/php/7.4/apache2/php.ini

# Enable apache mod_rewrite
a2enmod rewrite
a2enmod actions

# Change AllowOverride from None to All (between line 170 and 174)
sed -i '170,174 s/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf


# ---------------------------------------
#          MySQL Setup
# ---------------------------------------

# Setting MySQL root user password root/root
debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'


# Installing packages
apt-get install mysql-server -y

# Allow External Connections on your MySQL Service
sudo sed -i -e 's/bind-addres/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -u root -pvagrant -e "use mysql; update user set user='vagrant' where user='root'; GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%' IDENTIFIED BY 'vagrant'; FLUSH privileges;"
# mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%' IDENTIFIED BY 'vagrant'; FLUSH privileges;"
sudo service mysql restart
# create client database
# mysql -u root -proot -e "CREATE DATABASE myDB;"


# ---------------------------------------
#          PHPMyAdmin setup
# ---------------------------------------

# Default PHPMyAdmin Settings
debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password vagrant'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password vagrant'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password vagrant'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'

# Install PHPMyAdmin
apt-get install -y phpmyadmin


# Start the webserver
service apache2 restart


# Install composer
cd ~
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"
composer self-update

# Installing GIT
apt-get install git -y


# Symfony
cd ~
wget https://get.symfony.com/cli/installer -O - | bash
mv /root/.symfony/bin/symfony /usr/local/bin/symfony


# Create a symlink
#rm -rf /var/www
#mkdir /var/www
#ln -s /vagrant/public /var/www/html
