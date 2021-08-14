#!bin/bash

#WP_db
service mysql start
mysql -e "CREATE DATABASE wordpress; CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
          GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost' WITH GRANT OPTION;
          FLUSH PRIVILEGES;"

#phpMA_db
mysql < /var/www/server/phpmyadmin/sql/create_tables.sql
