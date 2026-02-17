#!/bin/bash

# Read secrets
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

echo "DEBUG: MYSQL_USER=$MYSQL_USER"
echo "DEBUG: MYSQL_DATABASE=$MYSQL_DATABASE"
echo "DEBUG: Password length: ${#MYSQL_PASSWORD}"

# Only initialize if database doesn't exist
if [ ! -d "/var/lib/mysql/mysql/user.frm" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    # Start temp server and run init commands
    mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF
    echo "MariaDB initialized!"
else
    echo "MariaDB already initialized, skipping setup."
fi
# Start MariaDB
exec mysqld --user=mysql --console