#!/bin/bash

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MariaDB service startup"
    sleep 5
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "status" > /dev/null 2>&1
    RET=$?
done

echo "=> Importing test_database"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE test_db"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} test_db < create_test_database.sql
echo "=> Imported"

echo "=> Granting access to all databases for '${MYSQL_USER}'"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION"

echo "=> Done!"
