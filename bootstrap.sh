#!/usr/bin/env bash

apt-get update

# unzip is for composer
apt-get install vim unzip  -y

apt-get install apache2 -y

apt-get install mysql-client libmysqlclient-dev -y
apt-get install libapache2-mod-php7.2 php7.2 php7.2-mysql php7.2-sqlite -y
apt-get install php7.2-mbstring php7.2-curl php7.2-intl php7.2-gd php7.2-zip php7.2-bz2 -y
apt-get install php7.2-dom php7.2-xml php7.2-soap -y
apt-get install --reinstall ca-certificates -y

# install the php xdebug extension (only for dev servers!)
apt-get install php-xdebug -y

# add xdebug settings to php.ini
echo 'xdebug.remote_port=9000' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.remote_enable=true' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.remote_connect_back=true' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.remote_autostart=on' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.remote_host=' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.max_nesting_level=1000' >> /etc/php/7.2/apache2/php.ini
echo 'xdebug.idekey=PHPSTORM' >> /etc/php/7.2/apache2/php.ini

# Enable apache mod_rewrite
a2enmod rewrite
a2enmod actions

# Change AllowOverride from None to All (between line 170 and 174)
sed -i '170,174 s/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

# ---------------------------------------
#          PHPMyAdmin setup
# ---------------------------------------

# Install PHPMyAdmin
#apt-get install -y phpmyadmin

# Default PHPMyAdmin Settings
#debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
#-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password root'
#debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password root'
#debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password root'
#debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'




# Start the webserver
service apache2 restart

# Install MySQL (optional)
#apt-get install mysql-server -y

# Change mysql root password
#service mysql start
#mysql -u root --password="" -e "update mysql.user set authentication_string=password(''), plugin='mysql_native_password' where user='root';"
#mysql -u root --password="" -e "flush privileges;"




# Install composer
cd ~
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"
composer self-update

# Installing GIT
apt-get install -y git


# Create a symlink
rm -rf /var/www
mkdir /var/www
ln -s /vagrant/public /var/www/html

# Symfony
wget https://get.symfony.com/cli/installer -O - | bash
mv /home/vagrant/.symfony/bin/symfony /usr/local/bin/symfony