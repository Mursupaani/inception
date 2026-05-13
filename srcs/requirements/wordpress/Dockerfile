FROM alpine:3.22.4

RUN addgroup -S www-data || true && adduser -S www-data -G www-data || true

RUN mkdir -p /run/php && chown www-data:www-data /run/php

RUN apk update && apk add --no-cache mariadb-client \
	php83 php83-fpm php83-phar php83-curl php83-mysqli php83-iconv php83-json \
	wget curl 

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY ./tools/wordpress_script.sh /usr/local/bin/wordpress_script.sh
RUN chmod +x /usr/local/bin/wordpress_script.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress_script.sh"]
