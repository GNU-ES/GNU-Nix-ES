#!/usr/bin/env bash

docker build --tag pedroregispoar/alpine-adduser-copy-etc-shadow-docker-python-from-nix .

docker run \
--interactive \
--rm \
--tty \
pedroregispoar/alpine-adduser-copy-etc-shadow-docker-python-from-nix \
python -c 'import flask; print(flask.__version__)'
