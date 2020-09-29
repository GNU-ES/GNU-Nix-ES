FROM ubuntu:12.04
# debian:buster-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    sudo \
 && apt-get -y autoremove \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*
