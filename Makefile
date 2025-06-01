NAME = sqlserver
COMPOSE_FILE = srcs/docker-compose.yml
USER := $(shell whoami)
DATA_DIR = /home/$(USER)/data/sqlserver
PORTAINER_DIR = /home/$(USER)/data/portainer
DBEAVER_DIR = /home/$(USER)/data/dbeaver
ENV_PATH = ./srcs/.env

all: init build up

init:
	@USER_NAME=$$(whoami); \
	if grep -q "^USER_NAME=" $(ENV_PATH) 2>/dev/null; then \
		sed -i "s/^USER_NAME=.*/USER_NAME=$$USER_NAME/" $(ENV_PATH); \
	else \
		echo "USER_NAME=$$USER_NAME" >> $(ENV_PATH); \
	fi
	@if [ ! -d $(DATA_DIR) ]; then \
		mkdir -p $(DATA_DIR); \
		chmod 777 $(DATA_DIR); \
		echo "Created $(DATA_DIR) with correct permissions"; \
	else \
		echo "$(DATA_DIR) already exists"; \
	fi
	@if [ ! -d $(PORTAINER_DIR) ]; then \
		mkdir -p $(PORTAINER_DIR); \
		chmod 777 $(PORTAINER_DIR); \
		echo "Created $(PORTAINER_DIR) with correct permissions"; \
	else \
		echo "$(PORTAINER_DIR) already exists"; \
	fi
	@if [ ! -d $(DBEAVER_DIR) ]; then \
		mkdir -p $(DBEAVER_DIR); \
		chmod 777 $(DBEAVER_DIR); \
		echo "Created $(DBEAVER_DIR) with correct permissions"; \
	else \
		echo "$(DBEAVER_DIR) already exists"; \
	fi


build:
	@docker compose -f $(COMPOSE_FILE) build --no-cache

up:
	@docker compose -f $(COMPOSE_FILE) up -d

down:
	@docker compose -f $(COMPOSE_FILE) down

clean: down
	@docker system prune -af

fclean: clean
	@docker volume prune -f
	@docker network prune -f
	@sudo rm -rf $(DATA_DIR)

re: fclean all

logs:
	@docker compose -f $(COMPOSE_FILE) logs -f

ps:
	@docker compose -f $(COMPOSE_FILE) ps

exec:
	@docker compose -f $(COMPOSE_FILE) exec sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrong!Passw0rd'

.PHONY: all init build up down clean fclean re logs ps exec
