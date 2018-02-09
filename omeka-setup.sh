#!/bin/bash

set -euo pipefail

cd /var/www/html

shopt -s dotglob

if ! [ -e index.php -a -e bootstrap.php ]; then
	echo "Omeka S copy to $PWD"
	cp -R -v /tmp/omeka-s/* .
	chown -R www-data .
        chmod -R g+w .
fi

if [ -v OMEKA_S_DB_USER -a -v OMEKA_S_DB_PASSWORD -a -v OMEKA_S_DB_NAME -a -v OMEKA_S_DB_HOST ]; then
	cat << EOS > ./config/database.ini
user     = "$OMEKA_S_DB_USER"
password = "$OMEKA_S_DB_PASSWORD"
dbname   = "$OMEKA_S_DB_NAME"
host     = "$OMEKA_S_DB_HOST"
EOS
fi

shopt -u dotglob

exec "$@"
