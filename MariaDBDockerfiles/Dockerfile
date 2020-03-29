FROM mariadb:10.3

# ENVIROMENT VARIABLES
ENV MYSQL_ROOT_PASSWORD=admin
ENV MYSQL_DATABASE=test_db
ENV MYSQL_USER=usuario
ENV MYSQL_PASSWORD=usuario

WORKDIR /usr/mysql_service

COPY create_test_database.sql ./
