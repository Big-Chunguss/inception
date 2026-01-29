#!/bin/bash

# Read passwords from secrets
export SQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
export SQL_PASSWORD=$(cat /run/secrets/db_password)

# Start MariaDB in the background
mysqld_safe &

# Wait for MariaDB to be available
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be available..."
    sleep 2
done

echo "MariaDB is ready!"

# Run initialization script with environment variable substitution
if [ -f /tools/init.sql ]; then
    envsubst < /tools/init.sql | mysql -u root -p"$SQL_ROOT_PASSWORD"
    echo "init.sql executed."
else
    echo "init.sql not found."
fi

# Keep the container running
wait