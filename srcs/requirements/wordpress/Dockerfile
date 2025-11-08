
#FROM = SYSTEM 
FROM debian:bookworm


# we need to update and upgrade (-y auto accept y/n) before to do somethink
RUN     apt-get update -y && apt-get upgrade -y


RUN     apt-get install -y wget mariadb-client php-fpm
#for wp
RUN     apt-get install -y php-cli php-mbstring php-xml php-curl php-zip php-gd php-mysql


# RUN     apt-get install -y iputils-ping

RUN     apt-get clean && rm -rf /var/lib/apt/lists/*

RUN set -e; \
    BIN=$(command -v php-fpm || command -v php-fpm8.3 || command -v php-fpm8.2 || command -v php-fpm7.4 || true); \
    if [ -n "$BIN" ]; then \
        ln -sf "$BIN" /usr/local/bin/php-fpm; \
        echo "[INFO] php-fpm found at $BIN, symlink created at /usr/local/bin/php-fpm"; \
    else \
        echo "[ERROR] php-fpm binary not found!" >&2; \
        exit 1; \
    fi


RUN     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN     chmod +x wp-cli.phar
RUN     mv wp-cli.phar /usr/local/bin/wp


COPY    ./conf/wordpress_entrypoint.sh /usr/local/bin/wordpress_entrypoint.sh 
RUN     chmod +x /usr/local/bin/wordpress_entrypoint.sh
COPY    ./conf/www.conf /etc/php/8.2/fpm/pool.d/.


WORKDIR /var/www/html


EXPOSE 9000


ENTRYPOINT [ "wordpress_entrypoint.sh" ]

#en user mysql do thit CMD
CMD ["php-fpm", "-F"]