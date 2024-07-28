docker stop cloudsql-backup
docker rm cloudsql-backup
docker build . -t cloudsql-backup
docker run --env-file .env --name cloudsql-backup -v ${PWD}/data:/app/data cloudsql-backup