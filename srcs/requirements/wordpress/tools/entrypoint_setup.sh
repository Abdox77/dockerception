#!/bin/sh

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

ln -s /usr/bin/php82 /usr/bin/php

cd /var/www/html

sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php82/php.ini

sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php82/php-fpm.d/www.conf

echo "Waiting for MariaDB at ${WP_DB_HOST} to be ready..."
until mysql -h"${WP_DB_HOST}" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1;" "${MYSQL_DATABASE}" >/dev/null 2>&1; do
    echo "MariaDB is unavailable - sleeping"
    sleep 2
done
echo "MariaDB is up - continuing..."
wp core download --locale=en_US

wp config create --dbhost="${WP_DB_HOST}" --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}"

wp core install --url="${DOMAIN_NAME}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USR}" --admin_password="${WP_ADMIN_PWD}" --admin_email="${WP_ADMIN_EMAIL}" --skip-email

wp user create "${WP_USER}" "${WP_USER_EMAIL}" --role=author --user_pass="${WP_USER_PWD}"

exec /usr/sbin/php-fpm82 -F

