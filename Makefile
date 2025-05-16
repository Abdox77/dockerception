all: build up

build:
	sudo mkdir -p /home/user/data/wordpress /home/user/data/mariadb  
	echo "Building Docker containers ..."
	docker compose -f srcs/docker-compose.yml build


up:
	echo "Starting containers ..."
	docker compose -f srcs/docker-compose.yml up -d

clean:
	docker compose -f
	srcs/docker-compose.yml down
	docker system prune -af

fclean:
	sudo rm -rf /home/user/data/wordpress /home/user/data/mariadb
	docker compose -f srcs/docker-compose.yml down
	docker system prune -af

re: fclean all

.PHONY: up down re fclean clean build all
