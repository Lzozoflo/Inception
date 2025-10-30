
#FROM = SYSTEM 
FROM debian:bookworm


RUN     apt-get update -y && apt-get upgrade -y

RUN     apt-get install wget -y

RUN     apt-get autoclean

COPY    ./conf/wordpress_entrypoint.sh wordpress_entrypoint.sh 
RUN     chmod +x wordpress_entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "./wordpress_entrypoint.sh" ]

#en user mysql do thit CMD
CMD ["yes"]