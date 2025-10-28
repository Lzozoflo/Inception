
FROM		:= -f srcs/docker-compose.yml
NPD			:= --no-print-directory
M			:= $(MAKE) $(NPD)


# use docker compose for 'build' all images to 'run -d'
up		: 
	docker compose $(FROM) build 
	docker compose $(FROM) up -d
	@$(M) show-images
	@$(M) clear

# use docker compose for 'stop' and down les volume
down 	:
	docker compose $(FROM) stop && docker compose $(FROM) down -v



# use other makefile cmd to finish all runtime proc and creat all again
re		:	cleardata down up




# rm all volume
cleardata	: clear
	sudo rm -rf ~/data/db/*

# rm images useless
clear		: 
	@docker image prune -f


#####################################
#									#
#				Debug				#		
#									#
#####################################


IMAGE_IDS	:= $(shell docker images | awk 'NR>1 {print $$3}')
show-images:
	@echo "Liste des IMAGE IDs :"
	@echo "$(IMAGE_IDS)"

dup		: cleardata
	docker compose up --build

dre		:	down dup

psa		:
	docker ps -a;
images		:
	docker images

view	:
	@$(M) psa
	@$(M) images


#########################################
#										#
#			go in the docker			#
#										#
#########################################


## docker exec -it its used to exec a cmd in the container here we use bash for seeing what working in
inm		:
	docker exec -it container_mariadb bash
inw		:
	docker exec -it container_wordpress_php_fpm bash
inn		:
	docker exec -it container_nginx bash




#####################################
#									#
#				Logs				#
#									#
#####################################

##
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