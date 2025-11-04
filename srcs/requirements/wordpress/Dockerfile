
#FROM = SYSTEM 
FROM debian:bookworm


## we need to update and upgrade (-y auto accept y/n) before to do somethink
RUN     apt-get update -y && apt-get upgrade -y


RUN     apt-get install -y wget php-fpm 
#for wp
RUN     apt-get install -y php-cli php-mbstring php-xml php-curl php-zip php-gd php-mysql


RUN     apt-get clean && rm -rf /var/lib/apt/lists/*


RUN     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN     chmod +x wp-cli.phar
RUN     mv wp-cli.phar /usr/local/bin/wp


COPY    ./conf/wordpress_entrypoint.sh /usr/local/bin/wordpress_entrypoint.sh 
RUN     chmod +x /usr/local/bin/wordpress_entrypoint.sh


WORKDIR /var/www/html


EXPOSE 9000


ENTRYPOINT [ "wordpress_entrypoint.sh" ]

#en user mysql do thit CMD
CMD ["yes "]