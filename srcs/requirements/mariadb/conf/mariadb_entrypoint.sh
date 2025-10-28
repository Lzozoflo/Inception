# mysql -u root
# CREATE OR REPLACE USER $(MYSQL_USER) IDENTIFIED BY $(MYSQL_PASSWORD);


#first creat a db
CREATE DATABASE WordPress;


#secound use this db
USE WordPress;


#creat a table for user
CREATE TABLE User (
    `user_id`             INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `user_login`          varchar(15) NOT NULL,
    `user_pass`           varchar(50) NOT NULL, 
    `user_email`          varchar(100) NOT NULL, 
    `user_registered`     DATETIME DEFAULT CURRENT_TIMESTAMP,
    `user_rule`           BOOLEAN
);


#with that u cant have duplicates
ALTER TABLE User
ADD UNIQUE (`user_login`);

ALTER TABLE User
ADD UNIQUE (`user_email`);


#creat user admyn with admin rule
INSERT INTO User (user_login, user_pass, user_email, user_rule)
VALUES ('admyn', 'adampass', 'admoi@mail.com', true);


#creat user pasadmyn
INSERT INTO User (user_login, user_pass, user_email, user_rule)
VALUES ('pasadmyn', 'pasadampass', 'admoipas@mail.com', false);

# #dup pasadmyn
# INSERT INTO User (user_login, user_pass, user_email, user_rule)
# VALUES ('pasadmyn', 'pasadampass', 'admoipa@mail.com', false)
# ON DUPLICATE KEY UPDATE user_pass = VALUES(user_pass);


#creat user pasadmy
INSERT INTO User (user_login, user_pass, user_email, user_rule)
VALUES ('pasadmy', 'pasadampa', 'admoipa@mail.com', false);

# #dup mail
# INSERT INTO User (user_login, user_pass, user_email, user_rule)
# VALUES ('pasadm', 'pasadampa', 'admoipa@mail.com', false);




## usefull cmd 

#   show all databases created
    #   SHOW databases;
#   show all table
    #   SHOW FULL TABLES;
#   
    #   DESCRIBE table_name;
#   show all user inside User.table with limit
    #   SELECT * FROM User LIMIT 10;
#   show all user mssql
    #   SELECT User, Host FROM mysql.user;