# FROM python:3.9.0rc1-slim-buster
FROM python:3.8.5-buster

# Set python environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PIP_NO_CACHE_DIR 0
# ENV PIP_DISABLE_PIP_VERSION_CHECK 1

RUN apt-get update \
 && apt-get install --no-install-recommends --no-install-suggests -y \
    ca-certificates \
    curl \
    xz-utils \
    sudo \
    tar \
 && apt-get -y autoremove \
 && apt-get -y clean  \
 && rm -rf /var/lib/apt/lists/*

COPY ./adduser-sudo.sh adduser-sudo.sh

RUN ./adduser-sudo.sh

RUN pip install --upgrade pip \
 && pip install Sphinx==3.2.1



