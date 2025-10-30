#!/bin/bash
set -e

echo "[INFO] Initialisation de MariaDB..."

# Var d'env attendues :
#   MYSQL_DATABASE, MYSQL_ROOT_PASSWORD, MYSQL_ADMYN_USER, MYSQL_ADMYN_PASSWORD, MYSQL_NOT_ADMYN_USER, MYSQL_NOT_ADMYN_PASSWORD

# Démarre le service en arrière-plan pour initialiser la DB
service mariadb start

# Si la base WordPress n’existe pas, la créer (la meme chose plus clair line: 42 *hehe🤭*)
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "[INFO] Création de la base $MYSQL_DATABASE..."
    mysql -e "CREATE DATABASE $MYSQL_DATABASE;"
    mysql -e "CREATE USER '$MYSQL_ADMYN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMYN_PASSWORD';"
    mysql -e "CREATE USER '$MYSQL_NOT_ADMYN_USER'@'%' IDENTIFIED BY '$MYSQL_NOT_ADMYN_PASSWORD';"
    mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_ADMYN_USER'@'%';"
    mysql -e "GRANT SELECT ON $MYSQL_DATABASE.* TO '$MYSQL_NOT_ADMYN_USER'@'%';"
    mysql -e "FLUSH PRIVILEGES;"
fi

# Stopper le service MariaDB lancé temporairement
service mariadb stop

# Exécuter la commande CMD (par défaut : mysqld_safe)
exec "$@"




#   show all user mssql
    #   SELECT User,Host FROM mysql.user;
    #   SHOW GRANTS FOR user@user;







# if [ ! -d "/var/lib/mysql/WordPress" ]; then
#     echo "[INFO] Création de la base WordPress..."
#     mysql -e "CREATE DATABASE WordPress;"
#     mysql -e "CREATE USER 'admyn'@'%' IDENTIFIED BY 'password';"
#     mysql -e "CREATE USER 'notadmyn'@'%' IDENTIFIED BY 'password';"
#     mysql -e "GRANT ALL PRIVILEGES ON WordPress.* TO 'admyn'@'%';"
#     mysql -e "GRANT SELECT ON WordPress.* TO 'notadmyn'@'%';"
#     mysql -e "FLUSH PRIVILEGES;"
# fi






# mysqld


# #first creat a db
# CREATE DATABASE WordPress;

# #secound use this db
# USE WordPress;

# CREAT USER 'admyn'@'pasadm1n' IDENTIFIED BY 'password';




# #creat a table for user
# CREATE TABLE User (
#     `user_id`             INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
#     `user_login`          varchar(15) NOT NULL,
#     `user_pass`           varchar(50) NOT NULL, 
#     `user_email`          varchar(100) NOT NULL, 
#     `user_registered`     DATETIME DEFAULT CURRENT_TIMESTAMP,
#     `user_rule`           BOOLEAN
# );


# #with that u cant have duplicates
# ALTER TABLE User
# ADD UNIQUE (`user_login`);

# ALTER TABLE User
# ADD UNIQUE (`user_email`);


# #creat user admyn with admin rule
# INSERT INTO User (user_login, user_pass, user_email, user_rule)
# VALUES ('admyn', 'adampass', 'admoi@mail.com', true);


# #creat user pasadmyn
# INSERT INTO User (user_login, user_pass, user_email, user_rule)
# VALUES ('pasadmyn', 'pasadampass', 'admoipas@mail.com', false);

# # #dup pasadmyn
# # INSERT INTO User (user_login, user_pass, user_email, user_rule)
# # VALUES ('pasadmyn', 'pasadampass', 'admoipa@mail.com', false)
# # ON DUPLICATE KEY UPDATE user_pass = VALUES(user_pass);


# #creat user pasadmy
# INSERT INTO User (user_login, user_pass, user_email, user_rule)
# VALUES ('pasadmy', 'pasadampa', 'admoipa@mail.com', false);

# #dup mail
# INSERT INTO User (user_login, user_pass, user_email, user_rule)
# VALUES ('pasadm', 'pasadampa', 'admoipa@mail.com', false);




## usefull cmd 

#   show all databases created
    #   SHOW databases;
#   show all table
    #   SHOW FULL TABLES;
#   
    #   DESCRIBE table_name;
#   show all user inside User.table with limit
    #   SELECT * FROM User LIMIT 10;


    
    
    #GRANT ALL PRIVILEGES ON dbTest.* To 'admyn@pasadm1n' IDENTIFIED BY 'password';