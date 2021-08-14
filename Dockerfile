FROM debian:buster

RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y wget vim nginx mariadb-server php-fpm php-mysql php-mbstring

COPY srcs/autoindex.sh srcs/start.sh srcs/db.sh srcs/ssl.sh ./

#install_and_conf_wordpress
WORKDIR /var/www/server
RUN wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && rm -rf latest.tar.gz
COPY srcs/wp-config.php /var/www/server/wordpress/

#install_and_conf_phpmyadmin
WORKDIR /var/www/server
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz && tar -xzvf phpMyAdmin-5.0.4-all-languages.tar.gz && \
    rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz && mv /var/www/server/phpMyAdmin-5.0.4-all-languages /var/www/server/phpmyadmin
COPY srcs/config.inc.php /var/www/server/phpmyadmin/

WORKDIR /
RUN chown -R www-data:www-data /var/www/* && chmod -R 755 /var/www/*
#conf_nginx
COPY srcs/nginx.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

#create_db_ssl
RUN bash db.sh && bash ssl.sh

EXPOSE 80 443

CMD bash start.sh
