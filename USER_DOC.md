# Inception - User Documentation

## Overview

This project provides a complete web hosting stack using Docker containers. The stack consists of three main services working together to deliver a fully functional WordPress website with HTTPS support.

### Services Provided

**NGINX** - Web server with TLS/SSL encryption
- Handles all incoming HTTPS requests
- Provides secure access to the website
- Routes traffic to the WordPress application

**WordPress** - Content management system
- Powers the website and blog functionality
- Provides an administration panel for managing content
- Accessible through a web browser

**MariaDB** - Database server
- Stores all website data (posts, pages, users, settings)
- Runs in the background
- Not directly accessible from outside the container network

## Getting Started

### Prerequisites
- Docker and Docker Compose must be installed on your system
- sudo privileges (for managing data directories)

### Starting the Project

To start all services:
```bash
cd /Inception
make build
make up
```

This command will:
1. Create necessary data directories
2. Start all three containers (NGINX, WordPress, MariaDB)
3. Run services in detached mode (background)

The first startup may take a few minutes as WordPress initializes and connects to the database.

### Stopping the Project

To stop all services while preserving data:
```bash
make down
```

This stops all containers but keeps your data intact.

## Accessing the Services

### Website Access

Open your web browser and navigate to:
```
https://your-domain.42.fr
```

Replace `your-domain.42.fr` with the actual domain name configured in the `.env` file.

### WordPress Administration Panel

To access the WordPress admin dashboard:
```
https://your-domain.42.fr/wp-admin
```

You'll be prompted to enter your administrator credentials (see Credentials section below).

## Managing Credentials

### Location of Credentials

Credentials are stored in two places:

1. **Environment file**: `./Inception/.env` (main configuration)
2. **Secrets directory**: `./Inception/secrets/` (individual password files)

### Available Credentials

**WordPress Administrator**
- Username: Defined in `.env` as `WP_ADMIN_USER`
- Password: Located in `secrets/credentials.txt` as `WP_ADMIN_PASSWORD`
- Use these credentials to log into the WordPress admin panel

**WordPress Regular User**
- Username: Defined in `.env` as `WP_USER`
- Password: Located in `secrets/credentials.txt` as `WP_USER_PASSWORD`
- A second user account with limited privileges

**Database Credentials**
- Database name: Defined in `.env` as `MYSQL_DATABASE`
- Database user: Defined in `.env` as `MYSQL_USER`
- Database password: Located in `secrets/db_password.txt`
- Root password: Located in `secrets/db_root_password.txt`

### Updating Credentials

To change credentials:
1. Stop the services: `make down`
2. Edit the `.env` file or files in `secrets/` directory
3. Clean the data: `make fclean` (this will delete all existing data!)
4. Rebuild and restart: `make re`

**Warning:** Changing credentials after initial setup requires a complete rebuild, which will erase all website content and data.

## Checking Service Status

### Verify All Containers Are Running

```bash
docker ps
```

You should see three containers running:
- `nginx` (or container with nginx in the name)
- `wordpress` (or container with wordpress in the name)
- `mariadb` (or container with mariadb in the name)

All containers should show status as "Up" for healthy operation.

### Check Individual Service Logs

To view logs for a specific service:
```bash
docker-compose -f srcs/docker-compose.yml logs -f nginx
docker-compose -f srcs/docker-compose.yml logs -f wordpress
docker-compose -f srcs/docker-compose.yml logs -f mariadb
```

### Test Website Accessibility

1. Open a web browser
2. Navigate to `https://your-domain.42.fr`
3. You should see the WordPress homepage


### Common Health Checks

**NGINX is working if:**
- The website URL returns a page (even if it's an error)
- You see the HTTPS padlock icon in your browser

**WordPress is working if:**
- The homepage displays content
- You can log into `/wp-admin`

**MariaDB is working if:**
- WordPress can display content (it needs the database)
- No database connection errors appear in logs

## Troubleshooting

### Services Won't Start

If you see volume conflicts:
```bash
docker volume prune -f
make up
```

### Permission Denied Errors

If you encounter permission errors with data directories:
```bash
sudo rm -rf ./data
make up
```

### Cannot Access Website

1. Check that all containers are running: `docker ps`
2. Verify the domain name in your `.env` file
3. Check NGINX logs: `docker-compose -f srcs/docker-compose.yml logs nginx`

### WordPress Shows Database Error

1. Check MariaDB logs: `docker-compose -f srcs/docker-compose.yml logs mariadb`
2. Verify database credentials in `.env` match those in `secrets/`
3. Restart services: `make down && make up`

## Complete Reset

To completely reset the project (deletes all data):
```bash
make fclean
make up
```

This will remove all containers, volumes, and data directories, giving you a fresh start.
