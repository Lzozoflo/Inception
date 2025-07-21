#!/bin/bash
# docker-entrypoint.sh

set -e

echo "Vérification de la connexion à la base de données MariaDB..."
# Attendre que le service "db" soit prêt
# Utilise les variables d'environnement de WordPress pour la connexion
while ! mysql -h "db" -u "${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" -e "SELECT 1" >/dev/null 2>&1; do
    echo "En attente de la base de données MariaDB..."
    sleep 2
done

echo "Base de données MariaDB prête !"

# Démarrer PHP-FPM en premier plan
exec php-fpm -F