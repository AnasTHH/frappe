#!/bin/bash
sudo adduser frappe --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "frappe:frappe" | sudo chpasswd
sudo usermod -aG sudo frappe
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

sudo apt-get update -y
touch ~/.sudo_as_admin_successful
cd ~frappe/

sudo su frappe -c git clone https://github.com/frappe/bench
sudo su frappe -c pip install -e ./bench
sudo su frappe -c bench init frappe-bench
cd frappe-bench
sudo su frappe -c bench new-site site1.local
sudo su frappe -c bench setup production
sudo su frappe -c bench setup supervisor
sudo su frappe -c supervisorctl reread
sudo su frappe -c supervisorctl reload
sudo su frappe -c supervisorctl restart all
