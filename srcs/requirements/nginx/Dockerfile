
#FROM = SYSTEM 
FROM debian:bookworm

## we need to update and upgrade (-y auto accept y/n) before to do somethink
RUN apt update -y;                                                           \
    apt install nginx -y openssl -y;                                                  
RUN openssl genrsa 2048 > ca-key.pem
RUN openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca.pem \
    -subj "/C=FR/ST=France/L=Paris/O=42/OU=Dev/CN=fcretin.42.fr"
RUN openssl genrsa 2048 > server-key.pem
RUN openssl req -new -key server-key.pem -out server.csr \
    -subj "/C=FR/ST=France/L=Paris/O=42/OU=Dev/CN=fcretin.42.fr"
RUN openssl x509 -req -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial \
    -out server-cert.pem -days 825 -sha256




# Copie conf_file for nginx
COPY ./conf/server.conf /etc/nginx/conf.d
EXPOSE 443



# CMD = default cmd on "docker run <image name> <default/cmd>" if no cmd added
CMD ["nginx", "-g", "daemon off;"]



# # EXPOSE = port to the host system
