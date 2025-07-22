#!/bin/bash
set -e

# Check if the database needs to be initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    # Initialize MariaDB data directory if it's empty
    # For a fresh install, this is typically done by 'mysql_install_db' or 'mariadb-install-db'
    # The exact command might vary slightly based on MariaDB version and packaging.
    # In Debian/Ubuntu, mariadb-install-db is often included.
    # We run it with --user=mysql to ensure correct ownership.
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB server temporarily for initialization scripts
echo "Starting MariaDB for initialization..."
mysqld_safe --datadir=/var/lib/mysql &
MYSQL_PID=$!

# Wait for MariaDB to be ready
# This is a simple wait; a more robust solution might check the socket or logs.
ATTEMPTS=0
while ! mysqladmin ping -hlocalhost --silent; do
    ATTEMPTS=$((ATTEMPTS+1))
    if [ $ATTEMPTS -ge 30 ]; then
        echo "MariaDB did not start in time. Exiting."
        kill $MYSQL_PID
        exit 1
    fi
    echo "Waiting for MariaDB to start... ($ATTEMPTS/30)"
    sleep 2
done
echo "MariaDB started."

# Execute SQL initialization scripts
for f in /docker-entrypoint-initdb.d/*.sql; do
    if [ -f "$f" ]; then
        echo "Executing SQL script: $f"
        mysql -uroot < "$f"
    fi
done

# Stop the temporary MariaDB server
echo "Stopping temporary MariaDB for final startup..."
mysqladmin shutdown
wait $MYSQL_PID

echo "MariaDB initialization complete."

# Execute the main command passed to the entrypoint (e.g., mysqld)
echo "Starting final MariaDB server..."
exec "$@"