#!/bin/sh

set -e

echo "Starting MariaDB initialization..."

if [ -f "$MYSQL_ROOT_PASSWORD_FILE" ]; then
	MYSQL_ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
else
	echo "ERROR: MYSQL_ROOT_PASSWORD_FILE ($MYSQL_ROOT_PASSWORD_FILE) not found!"
	exit 1
fi
if [ -f "$MYSQL_PASSWORD_FILE" ]; then
	WORDPRESS_DATABASE_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
else
	echo "ERROR: MYSQL_PASSWORD_FILE ($MYSQL_PASSWORD_FILE) not found!"
	exit 1
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initializing MariaDB system tables..."
	mariadb-install-db --basedir=/usr --user=mysql --datadir=/var/lib/mysql > /dev/null

#	sudo mariadb-secure-installation
	echo "Configuring database and users..."
	/usr/bin/mariadbd --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS \`$WORDPRESS_DATABASE_NAME\` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '$WORDPRESS_DATABASE_USER'@'%' IDENTIFIED BY '$WORDPRESS_DATABASE_PASSWORD';
GRANT ALL PRIVILEGES ON \`$WORDPRESS_DATABASE_NAME\`.* TO '$WORDPRESS_DATABASE_USER'@'%';
FLUSH PRIVILEGES;
EOF

else
	echo "MariaDB data directory already exists. Skipping initialization."
fi

if [ "$#" -eq 0 ]; then
	echo "No arguments provided, starting MariaDB default..."
	set -- /usr/bin/mariadbd --defaults-file=/etc/my.cnf.d/mariadb_config.cnf
fi

echo "Starting mariaDB..."
exec "$@"
