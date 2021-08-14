#!bin/bash

openssl req -x509 -days 365 -newkey rsa:2048 -nodes \
   -out /etc/ssl/certs/ft_server.crt -subj '/C=RU/ST=Tatarstan/L=Kazan/O=21_school/CN=mmaryjan'\
   -keyout /etc/ssl/private/ft_server.key
