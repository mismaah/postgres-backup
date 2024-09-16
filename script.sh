#!/bin/bash

now=$(date '+%Y-%m-%dT%H-%M-%S');

export PGPASSWORD=$PASSWORD

ALL_DBS=`psql -h $HOST -U $USER $DATABASE --tuples-only -c "SELECT datname FROM pg_database"`

mkdir /app/data/$now
for db in $ALL_DBS
do 
  for i in ${DATABASES//,/ }
  do
      if [ "$db" == "$i" ]; then
        pg_dump -v -h $HOST -U $USER $db | gzip -c > /app/data/$now/$db.sql.gzip
      fi
  done
done