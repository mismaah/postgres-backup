#!/bin/bash

docker stop cloudsql-backup
docker rm cloudsql-backup
docker build -f .\postgres.Dockerfile . -t cloudsql-backup
docker run --env-file .env --name cloudsql-backup -v ${PWD}/data:/app/data cloudsql-backup
