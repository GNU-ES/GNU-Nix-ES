#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


#TODO: inject $(git rev-parse --short HEAD) in the name

nix-build './docker-tools-example-1.nix'

docker load < ./result

docker run \
--interactive \
--rm \
--tty \
--rm \
docker-tools-example-1:0.0.1 \
bash -c 'sudo --version'
