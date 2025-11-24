#!/bin/bash
set -e

echo "[INFO] Initialisation de MariaDB..."

# Initialiser la base de données si elle n'existe pas
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "[INFO] Installation de la base de données système MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
else
    echo "[INFO] Installation système MariaDB deja faite..."
fi

# Var d'env attendues :
#   MYSQL_DATABASE, MYSQL_ADMYN_USER, MYSQL_ADMYN_PASSWORD, MYSQL_NOT_ADMYN_USER, MYSQL_NOT_ADMYN_PASSWORD

# Si la base WordPress n'existe pas, la créer
if [ ! -d "/var/lib/mysql/init.sql" ]; then
    echo "[INFO] Création de la base '$MYSQL_DATABASE' et des utilisateurs..."

    cat > /var/lib/mysql/init.sql << EOF
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db LIKE 'test_%';
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER IF NOT EXISTS '$MYSQL_ADMYN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMYN_PASSWORD';
CREATE USER IF NOT EXISTS '$MYSQL_NOT_ADMYN_USER'@'%' IDENTIFIED BY '$MYSQL_NOT_ADMYN_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO  '$MYSQL_ADMYN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMYN_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_NOT_ADMYN_USER'@'%' IDENTIFIED BY '$MYSQL_NOT_ADMYN_PASSWORD';
FLUSH PRIVILEGES;
EOF

else
    echo "[INFO] La base '$MYSQL_DATABASE' est deja crée..."

fi


# Exécuter la commande CMD (par défaut : mysqld_safe)
exec "$@"