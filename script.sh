#!/bin/bash

now=$(date '+%Y-%m-%dT%H-%M-%S');

ALL_DBS=`psql --dbname=postgresql://$CSQL_USER:$CSQL_PASSWORD@$CSQL_HOST --tuples-only -c "SELECT datname FROM pg_database"`

mkdir /app/data/$now
for db in $ALL_DBS
do 
  for i in ${DATABASES//,/ }
  do
      if [ "$db" == "$i" ]; then
        pg_dump -v --dbname=postgresql://$CSQL_USER:$CSQL_PASSWORD@$CSQL_HOST/$db | gzip -c > /app/data/$now/$db.sql.gzip
      fi
  done
done