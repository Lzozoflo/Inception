
# #FROM = SYSTEM 

# FROM debian:bullseye


# # RUN = image build cmd

# ## we need to update and upgrade (-y auto accept y/n) before to do somethink
# RUN apt update -y
# ## install mariadb
# RUN apt install -y mariadb-server

# COPY mariadb-entrypoint.sh 

# # # EXPOSE = port to the host system
# EXPOSE 3306

# # CMD = default cmd on "docker run <image name> <default/cmd>" if no cmd added
# CMD [""]











#FROM = SYSTEM 
FROM debian:bullseye

# RUN = image build cmd

## we need to update and upgrade (-y auto accept y/n) before to do somethink
RUN apt update -y
## install mariadb
RUN apt install -y mariadb-server

# Create a directory for SQL initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy your SQL script(s) into the container
# Assuming your SQL script is named 'init.sql' and is in the same directory as your Dockerfile
COPY init.sql /docker-entrypoint-initdb.d/

# Copy your mariadb-entrypoint.sh script
COPY mariadb-entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh

# EXPOSE = port to the host system
EXPOSE 3306

# ENTRYPOINT = This defines the default command to execute when the container starts.
# It allows your mariadb-entrypoint.sh script to control the startup process.
ENTRYPOINT ["mariadb-entrypoint.sh"]

# CMD = default cmd on "docker run <image name> <default/cmd>" if no cmd added
# This will be passed as arguments to the ENTRYPOINT script.
# In this case, we want to start the MariaDB server.
CMD ["mysqld"]