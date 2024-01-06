# FROM postgres:13.7-alpine3.16
FROM alpine

# Set to maldives time
RUN apk update
RUN apk upgrade
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --update tzdata
ENV TZ=Etc/GMT-5
RUN rm -rf /var/cache/apk/*

# Install pg_dump
RUN apk add --no-cache postgresql-client postgresql-libs postgresql-dev
RUN apk add --no-cache --virtual .build-deps gcc musl-dev

# Install python
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN apk add cmd:pip3
# RUN python3 -m ensurepip --break-system-packages
RUN pip3 install --no-cache --upgrade pip setuptools --break-system-packages
RUN apk add python3-dev

WORKDIR /app
COPY script.py ./
COPY requirements.txt ./
RUN pip3 install -r requirements.txt --break-system-packages
RUN mkdir data

ENTRYPOINT [ "/usr/bin/python3" ]

CMD ["script.py"]