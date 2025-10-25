
#FROM = SYSTEM 
FROM debian:Bookworm

## we need to update and upgrade (-y auto accept y/n) before to do somethink
RUN apt update -y
RUN apt install nginx -y

# Copie conf_file for nginx
# COPY nginx.conf /etc/nginx/nginx.conf



# CMD = default cmd on "docker run <image name> <default/cmd>" if no cmd added
CMD ["nginx", "-g", "daemon off;"]



# # EXPOSE = port to the host system
# EXPOSE 80













# # Active la configuration par défaut
# RUN rm /etc/nginx/sites-enabled/default && \
# ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# # /etc/nginx/nginx.conf ## tcl

