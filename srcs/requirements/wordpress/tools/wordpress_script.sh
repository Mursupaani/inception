#!/bin/sh
set -e

WP_PATH="/var/www/html"

chown -R 82:82 /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

if [ -n "$MYSQL_PASSWORD_FILE" ] && [ -f "$MYSQL_PASSWORD_FILE" ]; then
	export WORDPRESS_DB_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
fi

if [ -n "$WORDPRESS_ADMIN_PASSWORD_FILE" ] && [ -f "$WORDPRESS_ADMIN_PASSWORD_FILE" ]; then
	export WORDPRESS_ADMIN_PASSWORD=$(cat "$WORDPRESS_ADMIN_PASSWORD_FILE")
fi

if [ -n "$WORDPRESS_USER_PASSWORD_FILE" ] && [ -f "$WORDPRESS_USER_PASSWORD_FILE" ]; then
	export WORDPRESS_USER_PASSWORD=$(cat "$WORDPRESS_USER_PASSWORD_FILE")
fi

echo "Setting up WordPress..."

if [ ! -f "$WP_PATH/wp-settings.php" ]; then
    echo "Downloading WordPress..."
	php -d memory_limit=-1 /usr/local/bin/wp core download --allow-root
fi

if [ ! -f "$WP_PATH/wp-config.php" ]; then
	echo "Installing WordPress via WP-CLI..."

	wp config create --allow-root \
		--dbname=$WORDPRESS_DB_NAME \
		--dbuser=$WORDPRESS_DB_USER \
		--dbpass=$WORDPRESS_DB_PASSWORD \
		--dbhost=$WORDPRESS_DB_HOST

	wp core install --allow-root --skip-email \
		--url=$DOMAIN_NAME \
		--title=$WORDPRESS_TITLE \
		--admin_user=$WORDPRESS_ADMIN \
		--admin_password=$WORDPRESS_ADMIN_PASSWORD \
		--admin_email=$WORDPRESS_ADMIN_EMAIL

	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root

	chown -R 82:82 /var/www/html
    echo "WordPress setup complete."
else
    echo "WordPress already initialized, skipping setup."
fi
echo "Starting PHP-FPM..."
exec php-fpm83 -F
