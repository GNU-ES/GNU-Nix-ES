#!/usr/bin/env bash


docker build --file Dockerfile.root_user --tag pedroregispoar/alpine-adduser-copy-etc-shadow-docker-alpine_root_user-and-app_user .

docker run \
--interactive \
--rm \
--tty \
pedroregispoar/alpine-adduser-copy-etc-shadow-docker-alpine_root_user-and-app_user \
sh -c 'id -u && id -g && id -nG && id app_user && getent passwd | grep app_user && getent group app_group'


