# cloudsql-backup

Creates an SSH tunnel to a host with a static IP and then creates backups periodically from a GCP CloudSQL instance. The tunnel is needed so that the static IP can be whitelisted by CloudSQL.

Runs at 00:00 everyday. Change the schedule code in `script.py` to change backup intervals.

## Quickstart

Rename `.env.example` to `.env` and fill all variables.

Build docker image.
```powershell
docker build -t cloudsql-backup .
```

Run docker container.
```powershell
docker run --env-file .env -v $PWD/data:/app/data cloudsql-backup
```

The backups will be stored in the mounted volume.