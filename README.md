# cloudsql-backup

Creates backups periodically from a GCP CloudSQL instance. Optionally creates an SSH tunnel to a host with a static IP. The tunnel might be needed so that the static IP can be whitelisted by CloudSQL.

Runs at 00:00 everyday. Change the schedule code in `script.py` line 88 to change backup intervals.

## Quickstart

Rename `.env.example` to `.env` and fill all variables. If SSH tunnel is not required, no need to fill in the `TUNNEL_*` variables.

Build docker image.
```powershell
docker build -t cloudsql-backup .
```

Run docker container.
```powershell
docker run --env-file .env -v $PWD/data:/app/data cloudsql-backup
```

The backups will be stored in the mounted volume.