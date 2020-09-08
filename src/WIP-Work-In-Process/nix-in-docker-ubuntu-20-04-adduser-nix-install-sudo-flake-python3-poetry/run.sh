#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

IMAGE='gnu-nix-es/nix-in-docker-ubuntu-20-04-adduser-nix-install-sudo-flake-python3-poetry'
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

# Usefull for debug:
# echo -e " "'"$ENV->"'"$ENV\n" '"$NIX_PATH"->'"$NIX_PATH\n" '"$PATH"->'"$PATH\n" '"$USER"->' "$USER\n"


#docker run \
#--interactive \
#--tty \
#--user pedro \
#"$IMAGE_VERSION" --run "nix --version && nix profile install nixpkgs#python3 && python --version && python -c 'print(12345)'"


docker run \
--interactive \
--tty \
--rm \
--user pedro \
"$IMAGE_VERSION" --run "nix profile install nixpkgs#python3 nixpkgs#poetry && cd $HOME && poetry new foo && cd foo && poetry config virtualenvs.create false --local && python -m ensurepip --default-pip && poetry add flask && python -c 'import flask'"

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {

  buildInputs = [
    pkgs.python3
    pkgs.poetry
  ];

}
