FROM alpine:3.22.4

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes \
	-out /etc/nginx/ssl/public_certificate.crt \
	-keyout /etc/nginx/ssl/private.key \
	-subj "/C=FI/ST/Uusimaa/L=Helsinki/O=42/OU=Hive/CN=anpollan.42.fr"

RUN adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data

COPY ./conf/nginx_config.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf

COPY ./tools/nginx_script.sh /usr/local/bin/nginx_script.sh
RUN chmod +x /usr/local/bin/nginx_script.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/nginx_script.sh"]
