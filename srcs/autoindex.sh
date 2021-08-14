#!bin/bash

FILE='/etc/nginx/sites-available/nginx.conf'
CONF_TEXT=$(cat $FILE)
PHRASE='autoindex on'
if [[ $CONF_TEXT == *$PHRASE* ]]
then
    sed -i 's/autoindex on/autoindex off/' $FILE
    echo "autoindex off"
else
    sed -i 's/autoindex off/autoindex on/' $FILE
    echo "autoindex on"
fi
service nginx restart
