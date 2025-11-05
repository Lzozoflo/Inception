
#FROM = SYSTEM 
FROM debian:bookworm


## we need to update and upgrade (-y auto accept y/n) before to do somethink
RUN     apt-get update -y && apt-get upgrade -y


RUN     apt-get install -y mariadb-server mariadb-client


RUN     apt-get clean && rm -rf /var/lib/apt/lists/*

# Créer le répertoire et définir les permissions
RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod 755 /var/lib/mysql


RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    chmod 777 /run/mysqld
    

COPY    ./conf/my.cnf                   /etc/mysql/oui.cnf  
COPY    ./conf/mariadb_entrypoint.sh    mariadb_entrypoint.sh 
RUN     chmod +x mariadb_entrypoint.sh

EXPOSE 3306


ENTRYPOINT [ "./mariadb_entrypoint.sh" ]

#en user mysql do thit CMD
CMD ["mysqld", "--defaults-file=/etc/mysql/my.cnf", "--user=mysql", "--init-file=/tmp/init.sql"]