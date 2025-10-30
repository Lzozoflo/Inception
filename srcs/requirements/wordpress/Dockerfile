
#FROM = SYSTEM 
FROM debian:bookworm


## we need to update and upgrade (-y auto accept y/n) before to do somethink
RUN     apt-get update -y && apt-get upgrade -y


RUN     apt-get install wget -y


RUN     apt-get clean && rm -rf /var/lib/apt/lists/*


COPY    ./conf/wordpress_entrypoint.sh wordpress_entrypoint.sh 
RUN     chmod +x wordpress_entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "./wordpress_entrypoint.sh" ]

#en user mysql do thit CMD
CMD ["yes"]