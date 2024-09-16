docker stop postgres-backup
docker rm postgres-backup
docker build . -t postgres-backup
docker run --env-file .env --name postgres-backup -v ${PWD}/data:/app/data postgres-backup