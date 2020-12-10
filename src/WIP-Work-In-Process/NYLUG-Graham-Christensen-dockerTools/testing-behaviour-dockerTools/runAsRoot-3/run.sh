#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


#TODO: inject $(git rev-parse --short HEAD) in the name

nix-build './docker-tools-example-runAsRoot-3.nix'

docker load < ./result

docker run \
--interactive \
--rm \
--tty \
--rm \
docker-tools-example-runasroot-3:0.0.1 \
bash -c 'stat file.txt'
