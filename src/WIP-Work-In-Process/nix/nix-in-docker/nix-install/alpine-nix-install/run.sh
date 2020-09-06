#!/usr/bin/env sh

docker build --tag pedroregispoar/nixorg .

docker images | grep pedroregispoar/alpine-nix-install


docker run \
--interactive \
--rm \
--tty \
pedroregispoar/alpine-nix-install \
sh -c "nix --version && nix-env --install --attr nixpkgs.hello"
