#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

nix-build docker-redis-minimal.nix --out-link ./result

docker load --input=./result

docker pull redis:6.0.6-alpine3.12
docker pull redis:5.0.9-buster

docker images | grep redis
