#!/usr/bin/env bash

docker build --file Dockerfile.install-python-from-nixpkgs --tag pedroregispoar/alpine-adduser-copy-etc-shadow-docker-python-from-nix-manylinux .


docker run \
--detach \
--interactive \
--publish 5000:5000 \
--rm \
--tty \
pedroregispoar/alpine-adduser-copy-etc-shadow-docker-python-from-nix-manylinux \
sh -c 'nixfriday'



