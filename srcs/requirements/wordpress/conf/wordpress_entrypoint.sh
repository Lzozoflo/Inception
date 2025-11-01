#!/bin/bash
set -e

cd /var/www/html

echo "[INFO] Defaut WordPress..."


if [ -f "wp-settings.php" ]; then
    echo "already install."
else
    echo "wasnt install."
fi


if [ -f "wp-config.php" ]; then
    echo "already config."
else
    echo "wasnt config."
fi


exec "$@"
