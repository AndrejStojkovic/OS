FROM debian:12-slim

RUN apt-get update && apt-get install -y python3 && apt-get clean

RUN mkdir /srv/catalog

WORKDIR /srv/catalog

CMD [ "python3", "-m", "http.server", "9000", "--directory", "/srv/catalog" ]