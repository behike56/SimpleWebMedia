#!/bin/sh

# DBへの接続が確立する前にDjangoを起動するとMigrationが正しく動作しないので、MySQLを待つ。
if [ "$DATABASE" = "mysql" ]
then
    echo "Waiting for MySQL..."
    while ! nc -z $DATABASE_HOST $DATABASE_PORT; do
        sleep 0.1
    done
    echo "MySQL started"
fi

exec "$@"
