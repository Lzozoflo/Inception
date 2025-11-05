#!/bin/bash
set -e

cd /var/www/html


# Si WordPress n'est pas encore téléchargé
if [ ! -f "wp-settings.php" ]; then
    echo "[INFO] WordPress install.."
    wp core download --allow-root
else
    echo "[INFO] WordPress already downloaded..."
fi


# Si le fichier de config n'existe pas
if [ ! -f "wp-config.php" ]; then
    echo "[INFO] Create Config..."
    wp config create \
    --dbname="${WP_DB_NAME:-WordPress}" \
    --dbuser="${WP_DB_USER:-admin}" \
    --dbpass="${WP_DB_PASS:-adminadmin}" \
    --dbhost="${WP_DB_HOST:-db}" \
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

    echo "[INFO] Finish Install WordPress..."
else
    echo -n " already config."
fi

echo "\n"


exec "$@"`
