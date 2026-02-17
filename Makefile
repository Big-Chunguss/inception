NAME = inception
FOLDERS = /home/agaroux/data/wordpress /home/agaroux/data/mariadb

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
	docker system prune -af

fclean: 
	docker system prune -af --volumes
	sudo rm -rf $(FOLDERS)

re: fclean all
