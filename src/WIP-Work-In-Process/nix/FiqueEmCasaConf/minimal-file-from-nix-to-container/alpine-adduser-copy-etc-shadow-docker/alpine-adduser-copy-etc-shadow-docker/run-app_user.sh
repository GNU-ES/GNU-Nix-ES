#!/usr/bin/env bash


docker build --file Dockerfile.app_user --tag pedroregispoar/alpine-adduser-copy-etc-shadow-docker-alpine_app_user .

docker run \
--interactive \
--rm \
--tty \
pedroregispoar/alpine-adduser-copy-etc-shadow-docker-alpine_app_user \
sh -c 'id -u && id -g && id -nG && id app_user && getent passwd | grep app_user && getent group app_group'


