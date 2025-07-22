
ps :
	docker ps
psa		:
	docker ps -a


up		: cleardata
	docker compose up --build -d
down 	:
	docker compose stop && docker compose down -v
re		:	down up





cleardata :
	sudo rm -rf ~/data/db/*

#debug

dup		: cleardata
	docker compose up --build

dre		:	down dup

## to go in the docker
inm		:
	docker exec -it container_mariadb bash
inw		:
	docker exec -it container_wordpress_php_fpm bash
inn		:
	docker exec -it container_nginx bash

## to see all logs
debugs	: debugm debugw debugn

### logs off wordpress container
debugw	:
	docker logs container_wordpress_php_fpm

### logs off mariadb container
debugm	:
	docker logs container_mariadb

### logs off nginx container
debugn	:
	docker logs container_nginx