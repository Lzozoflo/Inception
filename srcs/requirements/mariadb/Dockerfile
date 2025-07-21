
#FROM = SYSTEM 

FROM debian:bullseye


# RUN = image build cmd

## we need to update and upgrade (-y auto accept y/n) before to do somethink
RUN apt update -y
## install mariadb
RUN apt install -y mariadb-server 


# CMD = default cmd on "docker run <image name> <default/cmd>" if no cmd added
CMD [""]
















# # Copie le fichier de configuration Nginx dans le conteneur
# COPY nginx.conf /etc/nginx/sites-available/default

# # Active la configuration par défaut
# RUN rm /etc/nginx/sites-enabled/default && \
# ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# # /etc/nginx/nginx.conf ## tcl


# # EXPOSE = port to the host system
# EXPOSE 80