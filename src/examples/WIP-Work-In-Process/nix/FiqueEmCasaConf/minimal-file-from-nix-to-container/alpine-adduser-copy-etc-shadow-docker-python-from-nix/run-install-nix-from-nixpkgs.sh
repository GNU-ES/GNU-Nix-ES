#!/usr/bin/env bash

docker build --file Dockerfile.install-nix-from-nixpkgs --tag pedroregispoar/alpine-adduser-copy-etc-shadow-docker-python-from-nix .

docker run \
--interactive \
--rm \
--tty \
pedroregispoar/alpine-adduser-copy-etc-shadow-docker-python-from-nix \
sh -c 'nix --version && nix-env --install --attr nixpkgs.neovim'

