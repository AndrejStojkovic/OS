FROM debian:12-slim

RUN apt-get update && apt-get install -y python3 && apt-get clean

RUN mkdir /data

WORKDIR /data

CMD [ "python3", "-m", "http.server", "8000", "--directory", "/data" ]