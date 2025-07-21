
#FROM = SYSTEM 

FROM debian:bullseye


# RUN = image build cmd

## we need to update and upgrade (-y auto accept y/n) before to do somethink
RUN apt update -y
## install Wordpress
RUN apt install -y \
    php-fpm \
    php-mysql \
    wordpress \
    php-cli \
    # Nettoyage des caches APT pour réduire la taille de l'image
    && rm -rf /var/lib/apt/lists/*

# Copie le script d'entrée dans le conteneur
COPY wordpress-entrypoint.sh /usr/local/bin/
# Rend le script exécutable
RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh

# Expose le port par défaut de PHP-FPM
EXPOSE 9000

# Définit le script d'entrée comme point d'entrée du conteneur
ENTRYPOINT ["/usr/local/bin/wordpress-entrypoint.sh"]
# CMD vide car l'ENTRYPOINT gère le démarrage
CMD []