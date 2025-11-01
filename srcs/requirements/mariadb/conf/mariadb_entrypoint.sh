#!/bin/bash
set -e


echo "[INFO] Initialisation de MariaDB..."


# chown -R mysql:mysql /var/lib/mysql
# chmod 755 /var/lib/mysql


# Initialiser la base de données si elle n'existe pas
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "[INFO] Installation de la base de données système MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi


# Var d'env attendues :
#   MYSQL_DATABASE, MYSQL_ADMYN_USER, MYSQL_ADMYN_PASSWORD, MYSQL_NOT_ADMYN_USER, MYSQL_NOT_ADMYN_PASSWORD


# Démarre le service en arrière-plan pour initialiser la DB
service mariadb start


# Si la base WordPress n'existe pas la créer (plus clair : line 42 - 40 help.txt)
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "/n[INFO] Création de la base $MYSQL_DATABASE..."
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