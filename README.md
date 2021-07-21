# introduction

docker image containing python 3.9 in alpine version, and having pandas and numpy installed as this can take some time to compile.

## why

pandas needs g++ which is not available in the base alpine image. Therefore you would need to install g++ first and compile pandas, which takes some time. Therefore it is easier to use this precreated image. 

## non-root vs root version

I recommend using the non-root version as this is best practice when creating docker images. Therefore, if you do not need root (should not be necessary), use the non-root version. 

If you need to install pip packages briefly switch to the root user, install everything, and switch back, e.g.

```
FROM guestros/python-alpine-pandas-nonroot:latest
USER root
RUN pip install <packages>
USER pythy
ENTRYPOINT ["python","app.py"]
```

Github Repo:
https://github.com/JustinGuese/docker-python-pandas-alpine-rootnonroot

Root version (not recommended):
- guestros/python-alpine-pandas:latest
    - https://hub.docker.com/repository/docker/guestros/python-alpine-pandas-nonroot

Non-Root version (recommended):
- guestros/python-alpine-pandas-nonroot:latest
    - https://hub.docker.com/repository/docker/guestros/python-alpine-pandas


# Dockerfile

## Dockerfile Root version

```
FROM python:alpine
MAINTAINER Justin Guese <info@datafortress.cloud>
# pandas needs g++
RUN apk update && apk upgrade --no-cache
RUN apk add --no-cache g++
RUN pip install pandas numpy
RUN apk del g++
RUN mkdir /app
WORKDIR /app
```

## Dockerfile Non-Root version (recommended)

```
FROM docker.io/guestros/python-alpine-pandas:latest
MAINTAINER Justin Guese <info@datafortress.cloud>
# it's always safer to use a new user, but skip this if you do not need it yet
ARG UNAME=pythy
ARG UID=1008
ARG GID=1008
RUN addgroup -g $GID $UNAME
RUN adduser -S $UNAME -u $UID -G $UNAME -H -D -s /bin/sh
RUN chown -R $UID:$GID /app
USER $UNAME
```
