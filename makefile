

# use docker compose for 'build' all images to 'run -d'
up		: cleardata
	docker compose up --build -d

# use docker compose for 'stop' and down les volume
down 	:
	docker compose stop && docker compose down -v

# use other makefile cmd to finish all runtime proc and creat all again
re		:	down up



# rm l'emplacement des volume
cleardata :
	sudo rm -rf ~/data/db/*








#debug

dup		: cleardata
	docker compose up --build

dre		:	down dup

# cmd docker use for see if ur images is up is close exited (to manual delete)
psa		:
	docker ps -a

# cmd docker use for see if what images u creat (to manual delete) docker rmi 
images		:
	docker images

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