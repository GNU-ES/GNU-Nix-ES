#!/usr/bin/env bash

nix-build mwe-input-file-data.nix

#ls
#
#ls -l $(readlink result)
#
#cat result
#
#cat $(readlink result)
#
#nix-store --query --requisites $(readlink result)

docker build --tag pedroregispoar/mwe-nixos-to-docker-image .

docker run \
--interactive \
--rm \
--tty \
pedroregispoar/mwe-nixos-to-docker-image \
sh


