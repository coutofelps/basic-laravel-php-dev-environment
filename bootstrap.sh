#!/bin/bash
# sudo apt-get install ubuntu-gnome-desktop
# sudo apt-get update
# sudo apt-get install ubuntu-desktop

log_file=/tmp/vagrantup.log

exec &> >(tee -a "$log_file")
common_packages=(curl git unzip make gcc build-essential make libpng-devel rsync openssh-clients zip unzip wget)

install_commom_packages()
{
    sudo apt-get -y install ${common_packages[@]}
}

install_php_packages()
{
    which php > /dev/null

    if [ $? -ne 0 ]; then
        sudo apt-get install software-properties-common
        sudo add-apt-repository ppa:ondrej/php
        sudo apt-get update
        sudo apt-get -y install php7.3
        php_packages=(php-cli php-cgi php-soap php-xml php-common php-json php-mysql php-mbstring php-mcrypt php-zip php-fpm php-gd)
        sudo apt-get -y install ${php_packages[@]}
        sudo a2enmod proxy_fcgi setenvif
        sudo a2enconf php7.3-fpm
    else
        echo "PHP packages are already installed!"
    fi
}

install_composer()
{
    cd ~
    curl -sS https://getcomposer.org/installer -o composer-setup.php
    sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
}

install_mysql()
{
    which mysql > /dev/null
    
    if [ $? -ne 0 ]; then
        # Removes previously installation if it exists
        sudo apt-get -y remove --purge mysql*
        sudo apt-get -y purge mysql*
        sudo apt-get -y autoremove
        sudo apt-get -y autoclean
        sudo apt-get -y remove dbconfig-mysql

        # Download and install the latest updates for the OS
        sudo apt-get -y update

        # Enable Ubuntu firewall and allow SSH & MySQL ports
        sudo ufw allow 22
        sudo ufw allow 3306

        # Install essential packages
        sudo apt-get -y install zsh htop

        # Install MySQL server in a non-interactive mode. Default root password will be "root"
        echo "mysql-server mysql-server/root_password password root" | sudo debconf-set-selections
        echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
        sudo apt-get -y install mysql-server
        sudo sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
        sudo mysql -uroot -proot -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

        sudo /etc/init.d/mysql restart
    else
        echo "MySQL is already installed!"
    fi
}

install_nodejs()
{
    sudo apt-get install -y nodejs
}

install_npm()
{
    sudo apt-get install -y npm
}

echo "###########################"
echo "Installing common packages..."
echo "###########################"
install_commom_packages
echo "###########################"

echo "###########################"
echo "Installing PHP packages..."
echo "###########################"
install_php_packages
echo "###########################" 

echo "###########################"
echo "Installing Composer..."
echo "###########################"
install_composer
echo "###########################"

echo "###########################"
echo "Installing Node.js..."
echo "###########################"
install_nodejs
echo "###########################"

echo "###########################"
echo "Installing NPM..."
echo "###########################"
install_npm
echo "###########################"

echo "###########################"
echo "Installing MySQL..."
echo "###########################"
install_mysql
echo "###########################"