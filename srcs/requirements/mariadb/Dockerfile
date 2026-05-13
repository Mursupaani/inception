FROM alpine:3.22.4

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN	mkdir -p /run/mariadb \
	&& chown -R mysql:mysql /run/mariadb \
	&& chmod 755 /run/mariadb

COPY ./conf/mariadb_config.cnf /etc/my.cnf.d/mariadb_config.cnf
RUN chmod 644 /etc/my.cnf.d/mariadb_config.cnf

COPY ./tools/mariadb_script.sh /usr/local/bin/mariadb_script.sh
RUN chmod +x /usr/local/bin/mariadb_script.sh

EXPOSE 3306

ENTRYPOINT ["mariadb_script.sh"]

CMD ["/usr/bin/mariadbd", "--defaults-file=/etc/my.cnf.d/mariadb_config.cnf"]
