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

RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/pedro --gecos "User" pedro

RUN echo "pedro:123" | chpasswd

RUN usermod -a -G sudo pedro

# COPY ./poetry.toml poetry.toml
# COPY ./poetry.lock poetry.lock

RUN pip install --upgrade pip \
 && pip install sphinx

USER pedro


