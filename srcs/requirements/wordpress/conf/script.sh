#!/bin/bash

cd /var/www/wordpress

# Download wp-cli if not present
if [ ! -f wp-cli.phar ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
fi

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/credentials | grep WP_ADMIN_PASSWORD | cut -d'=' -f 2)
WP_USER_PASSWORD=$(cat /run/secrets/credentials | grep WP_USER_PASSWORD | cut -d'=' -f 2)

# Download WordPress if not present
if [ ! -f wp-includes/version.php ]; then
    echo "Downloading WordPress..."
    ./wp-cli.phar core download --allow-root
fi

echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
    echo "MariaDB is unavailable - sleeping"
    sleep 2
done
echo "MariaDB is ready!"

# Create wp-config.php ONLY if it doesn't exist
if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php..."
    ./wp-cli.phar config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$MYSQL_HOST" \
        --allow-root
fi

# Install WordPress ONLY if not already installed
if ! ./wp-cli.phar core is-installed --allow-root 2>/dev/null; then
    echo "Installing WordPress..."
    ./wp-cli.phar core install \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root
    
    # Create additional user during installation
    echo "Creating additional user..."
    ./wp-cli.phar user create \
        "$WP_USER" \
        "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root
    
    echo "WordPress installation complete!"
else
    echo "WordPress already installed, skipping installation."
fi

echo "Starting PHP-FPM..."
php-fpm8.2 -F