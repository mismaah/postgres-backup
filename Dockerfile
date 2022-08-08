# FROM postgres:13.7-alpine3.16
FROM alpine

# Install pg_dump
RUN apk add --no-cache postgresql-client postgresql-libs postgresql-dev
RUN apk add --no-cache --virtual .build-deps gcc musl-dev

# Install python
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN apk add python3-dev

WORKDIR /app
COPY script.py ./
COPY requirements.txt ./
RUN pip3 install -r requirements.txt
RUN mkdir data

ENTRYPOINT [ "/usr/bin/python3" ]

CMD ["script.py"]