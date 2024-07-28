FROM postgres:15.7

ENV TZ=Etc/GMT-5

WORKDIR /app
COPY script.sh .

CMD ["bash",  "script.sh"]
