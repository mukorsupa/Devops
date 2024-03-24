#!/bin/bash

# Install MySQL and dependencies
sudo apt-get update
sudo apt-get install -y mysql-server

. /etc/environment 

# Customize MySQL configuration for private network access
sudo sed -i "s/bind-address\s*= .*/bind-address = 192.168.50.10/" /etc/mysql/mysql.conf.d/mysqld.cnf
echo "MySQL bind address updated." 

# Restart MySQL for changes to take effect
sudo systemctl restart mysql
echo "MySQL restarted."

# Create non-root user and database (using environment variables)
mysql -uroot -e "CREATE DATABASE ${DB_NAME};"
echo "Database ${DB_NAME} created."

mysql -uroot -e "CREATE USER '${DB_USER}'@'192.168.50.0/24' IDENTIFIED BY '${DB_PASS}';" 
echo "User ${DB_USER} created."

mysql -uroot -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'192.168.50.0/24';" 
echo "Privileges granted."
