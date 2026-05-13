#!/bin/sh
set -e

mkdir -p /etc/nginx/ssl

: "${DOMAIN_NAME:=anpollan.42.fr}"

if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    echo "Generating self-signed SSL certificate for ${DOMAIN_NAME}..."

    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=FI/ST=Uusimaa/L=Helsinki/O=42/CN=${DOMAIN_NAME}"

    chmod 600 /etc/nginx/ssl/nginx.key
    chmod 644 /etc/nginx/ssl/nginx.crt

    echo "SSL certificate generated at /etc/nginx/ssl/"
else
    echo "SSL certificate already exists. Skipping generation."
fi

echo "Replacing \${DOMAIN_NAME} in nginx.conf..."
sed -i "s/\${DOMAIN_NAME}/${DOMAIN_NAME}/g" /etc/nginx/nginx.conf

echo "Testing nginx configuration..."
nginx -t
echo "Nginx configuration test passed."

echo "Starting Nginx..."
exec nginx -g "daemon off;"
