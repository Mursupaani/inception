DATA_DIR		:= /home/anpollan/data
MARIADB_DIR		:= $(DATA_DIR)/mariadb
WORDPRESS_DIR	:= $(DATA_DIR)/wordpress
DOCKER_COMPOSE	:= ./srcs/docker-compose.yml

all:
	mkdir -p $(MARIADB_DIR)
	mkdir -p $(WORDPRESS_DIR)
	docker compose -f $(DOCKER_COMPOSE) up --build

up:
	docker compose -f $(DOCKER_COMPOSE) up

down:
	docker compose -f $(DOCKER_COMPOSE) down

clean:
	docker compose -f $(DOCKER_COMPOSE) down -v --rmi all --remove-orphans

fclean: clean
	sudo rm -rf /home/anpollan/data/mariadb/
	sudo rm -rf /home/anpollan/data/wordpress/

logs:
	docker compose -f $(DOCKER_COMPOSE) logs

check:
	docker compose -f $(DOCKER_COMPOSE) ps

re: fclean all

.PHONY: all fclean re up down
