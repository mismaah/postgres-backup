# postgres-backup

Docker container to automate backups from a PostgreSQL instance.

## Quickstart

Rename `.env.example` to `.env` and fill all variables.
Run the `docker.sh` or `docker.ps1` script.
This script will build the image and run the container.
The databases to be backed up are based on the `DATABASES` env variable.
The container will mount to a host directory `./data` where the backups will be stored.
They will be in gzip format so would need to be unzipped before restoring.

Can use cron from the host machine for scheduling to run the script.
