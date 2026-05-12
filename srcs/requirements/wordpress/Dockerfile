FROM alpine:3.22.4

RUN apk update && apk add --no-cache mariadb-client \
	php83 php83-fpm php83-phar php83-curl php83-mysqli php83-iconv php83-json \
	wget curl

WORKDIR /var/www/html

COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY ./tools/wordpress_script.sh /usr/local/bin/wordpress_script.sh
RUN chmod +x /usr/local/bin/wordpress_script.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress_script.sh"]

# CMD ["/usr/local/bin/setup_wordpress.sh"]
