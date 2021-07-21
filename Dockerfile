FROM python:alpine
MAINTAINER Justin Guese <info@datafortress.cloud>
# pandas needs g++
RUN apk update && apk upgrade --no-cache
RUN apk add --no-cache g++
RUN pip install pandas numpy
# needed for pandas
RUN apk add libstdc++
RUN apk del g++
RUN mkdir /app
WORKDIR /app
# it's always safer to use a new user, but skip this if you do not need it yet
# ARG UNAME=pythy
# ARG UID=1008
# ARG GID=1008
# RUN addgroup -g $GID $UNAME
# RUN adduser -S $UNAME -u $UID -G $UNAME -H -D -s /bin/sh
# RUN chown -R $UID:$GID /app
# USER $UNAME
