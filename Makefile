NAME = sqlserver
COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = /home/srandria/data/sqlserver_data

all: init build up

init:
	@if [ ! -d $(DATA_DIR) ]; then \
		mkdir -p $(DATA_DIR); \
		chmod 777 $(DATA_DIR); \
		echo "Created $(DATA_DIR) with correct permissions"; \
	else \
		echo "$(DATA_DIR) already exists"; \
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
