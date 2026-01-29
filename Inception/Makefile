NAME = inception
FOLDERS = ~/data/wordpress ~/data/mariadb

.PHONY: all build up down clean fclean re

all: build

$(FOLDERS):
	mkdir -p $@

build :
	docker-compose -f srcs/docker-compose.yml build

up : $(FOLDERS)
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker system prune -af --volumes

fclean: down clean

re: fclean all
