
FROM		:= -f srcs/docker-compose.yml
NPD			:= --no-print-directory
M			:= $(MAKE) $(NPD)


# use docker compose for 'build' all images to 'run -d'
up		: 
	docker compose $(FROM) build
	docker compose $(FROM) up -d
	@$(M) show-images


# use docker compose for 'stop' and down les volume
down 	:
	docker compose $(FROM) stop && docker compose $(FROM) down -v


# use other makefile cmd to finish all runtime proc and creat all again
re		:	 cleardata down up




# rm all volume
cleardata	: clear
	sudo rm -rf /home/fcretin/data/*

# rm images useless
clear		: down
	@docker system prune -f
	@docker image prune -f


#####################################
#									#
#				Debug				#		
#									#
#####################################


IMAGE_IDS	:= $(shell docker images | awk 'NR>1 {print $$2}')
show-images:
	@echo "Liste des IMAGE (ID) :"
	@echo "\t$(IMAGE_IDS)"

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
	docker exec -it mariadb bash
inw		:
	docker exec -it wordpress bash
inn		:
	docker exec -it nginx bash




#####################################
#									#
#				Logs				#
#									#
#####################################

##
debugs	: 
	$(MAKE) $(NPD) debugm;
	$(MAKE)	$(NPD) debugw;
	$(MAKE) $(NPD) debugn;

### logs off wordpress container
debugw	:
	docker logs wordpress

### logs off mariadb container
debugm	:
	docker logs mariadb

### logs off nginx container
debugn	:
	docker logs nginx