
#FROM = SYSTEM 
FROM debian:bookworm


RUN     apt-get update -y && apt-get upgrade -y

RUN     apt-get install mariadb-server -y

RUN     apt-get autoclean

COPY    ./conf/mariadb_entrypoint.sh mariadb_entrypoint.sh 
RUN     chmod +x mariadb_entrypoint.sh

# Crée un dossier pour le socket perm pour le user mysql
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

EXPOSE 3306

ENTRYPOINT [ "./mariadb_entrypoint.sh" ]

#en user mysql do thit CMD
CMD ["mysqld_safe"]