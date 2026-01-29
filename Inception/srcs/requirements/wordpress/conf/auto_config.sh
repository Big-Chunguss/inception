#!/bin/bash

# Read passwords from secrets
source /run/secrets/credentials
WP_ADMIN_PASSWORD=$(grep "WP_ADMIN_PASSWORD" /run/secrets/credentials | cut -d'=' -f2)
WP_USER_PASSWORD=$(grep "WP_USER_PASSWORD" /run/secrets/credentials | cut -d'=' -f2)
SQL_PASSWORD=$(cat /run/secrets/db_password)

# Wait for MariaDB to be ready
until mysqladmin ping -h"mariadb" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done
echo "MariaDB is ready!"

if [ ! -f wp-config.php ]; then
    wp config create    --allow-root \
                        --dbname=$SQL_DATABASE \
                        --dbuser=$SQL_USER \
                        --dbpass=$SQL_PASSWORD \
                        --dbhost=mariadb:3306 --path='/var/www/wordpress'
fi

if ! wp core is-installed --allow-root --path='/var/www/wordpress'; then
    wp core install --allow-root \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --path='/var/www/wordpress'

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --allow-root \
        --path='/var/www/wordpress'
fi

if [ ! -d /run/php ]; then
    mkdir /run/php
fi

exec /usr/sbin/php-fpm8.2 -F -R