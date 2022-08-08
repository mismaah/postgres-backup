import subprocess
import psycopg2
import schedule
import datetime
import os
import time
from sshtunnel import SSHTunnelForwarder
from dotenv import load_dotenv

load_dotenv()


def env(variable: str) -> str:
    return os.getenv(variable)


def task():
    now = datetime.datetime.utcnow().strftime("%Y-%m-%dT%H-%M-%S")
    print(now)
    try:
        with SSHTunnelForwarder(
            (env("TUNNEL_HOST"), 22),
            ssh_username=env("TUNNEL_USERNAME"),
            ssh_password=env("TUNNEL_PASSWORD"),
            remote_bind_address=(env("CSQL_HOST"), 5432),
        ) as server:

            server.start()
            print("server connected")

            params = {
                "database": env("CSQL_DATABASE"),
                "user": env("CSQL_USER"),
                "password": env("CSQL_PASSWORD"),
                "host": "localhost",
                "port": server.local_bind_port,
            }

            conn = psycopg2.connect(**params)
            curs = conn.cursor()
            print("database connected")
            curs.execute("SELECT datname FROM pg_database;")
            dbs = curs.fetchall()
            dbs = [i[0] for i in dbs]
            envDbs = env("DATABASES").split(",")
            dbs = [i for i in dbs if i in envDbs]
            print(dbs)

            print("Creating new backup directory")
            subprocess.run(f"mkdir /app/data/${now}", shell=True)
            for db in dbs:
                subprocess.run(
                    f'pg_dump --dbname=postgresql://{env("CSQL_USER")}:{env("CSQL_PASSWORD")}@localhost:{server.local_bind_port}/{db} > /app/data/${now}/{db}.dump',
                    shell=True,
                )
                print(f"Dumped {db}")

    except Exception as e:
        print(e)
        print("Connection Failed")


schedule.every(5).minute.do(task)

while True:
    schedule.run_pending()
    time.sleep(1)
