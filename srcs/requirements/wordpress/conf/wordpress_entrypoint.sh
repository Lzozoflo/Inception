#!/bin/bash
set -e

cd /var/www/html


echo -n "[INFO]"


# Si WordPress n'est pas encore téléchargé
if [ ! -f "wp-settings.php" ]; then
    wp core download --allow-root
else
    echo -n " WordPress already downloaded..."
fi


# Si le fichier de config n'existe pas
if [ ! -f "wp-config.php" ]; then
    echo "[INFO] Create Config..."
    wp config create \
    --dbname="${DB_NAME:-WordPress}" \
    --dbuser="${DB_USER:-admyn}" \
    --dbpass="${DB_PASS:-1234}" \
    --dbhost="${DB_HOST:-db}" \
    --skip-check \
    --allow-root

    echo "[INFO] Install WordPress..."
    wp core install \
    --url="${WP_URL:-http://localhost}" \
    --title="${WP_TITLE:-Mon site WordPress}" \
    --admin_user="${WP_ADMIN_USER:-admin}" \
    --admin_password="${WP_ADMIN_PASS:-admin}" \
    --admin_email="${WP_ADMIN_EMAIL:-admin@example.com}" \
    --skip-email \
    --allow-root

else
    echo -n " already config."
fi

echo "\n"


# exec "$@"
