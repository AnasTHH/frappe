#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y 
sudo apt-get install git -y 
sudo apt-get install python-dev -y 
sudo apt-get install python-setuptools python-pip -y 
sudo apt-get install software-properties-common -y 
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.ubuntu-tw.org/mirror/mariadb/repo/10.3/ubuntu xenial main'
sudo apt-get update -y
sudo apt-get upgrade -y 
sudo apt-get install mariadb-server -y 
sudo apt-get install libmysqlclient-dev -y 
echo "[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
[mysql]
default-character-set = utf8mb4" >> /etc/mysql/my.cnf

sudo service mysql restart
sudo apt-get install redis-server -y 
sudo apt-get install curl -y 
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install npm -y 
sudo npm install -g yarn -y 
echo "127.0.0.1	site1.local" >> /etc/hosts

adduser frappe 
sudo usermod -aG sudo frappe
cd ~frappe/
su frappe
git clone https://github.com/frappe/bench
sudo pip install -e ./bench
sudo bench init frappe-bench
cd frappe-bench
sudo bench new-site site1.local
sudo bench setup production
sudo bench setup supervisor
sudo supervisorctl reread
sudo supervisorctl reload
sudo supervisorctl restart all
