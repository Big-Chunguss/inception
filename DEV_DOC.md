## How to setup the environment from scratch

### Prerequisites
- Docker and Docker Compose installed
- Make utility
- sudo privileges (for data directory management)

### Configuration files and secrets
You need to define the following variables inside of `.env` at the root of the project (`./srcs/.env`):
```
DOMAIN_NAME=your-domain.42.fr
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
WP_URL=https://your-domain.42.fr
WP_TITLE=Your Site Title
WP_ADMIN_USER=admin_username
WP_ADMIN_EMAIL=admin@example.com
WP_USER=regular_user
WP_USER_EMAIL=user@example.com
```

You also need to create password files in the `secrets/` directory:
- `secrets/db_password.txt` - MySQL user password
- `secrets/db_root_password.txt` - MySQL root password
- `secrets/credentials.txt` - WordPress passwords (format: `WP_ADMIN_PASSWORD=xxx` and `WP_USER_PASSWORD=xxx` on separate lines)

## Build and launch the project from scratch

### Build the containers
```bash
make build
```

### Start all services
```bash
make up
```

### Stop all services
```bash
make down
```

### Rebuild everything from scratch
```bash
make re
```

## Relevant commands to manage containers and volumes

### View running containers
```bash
docker ps
```

### View container logs
```bash
docker-compose -f srcs/docker-compose.yml logs -f [service_name]
```

### Access a container shell
```bash
docker exec -it [container_name] /bin/sh
```

### Remove all volumes (clean slate)
```bash
docker volume prune -f
```

### Clean up everything
```bash
make fclean
```

## Where the project data is stored

The project data is stored in the data folder inside of the project which is generated at run time:
```bash
./Inception/data/wordpress  # WordPress files
./Inception/data/mariadb    # MariaDB database files
```

### Data persistence
- Data persists between container restarts through Docker volumes
- Volumes are mapped to the local `data/` directory
- To completely reset data, run `make fclean` which removes containers, volumes, and data directories
- Running `make down` stops containers but preserves data