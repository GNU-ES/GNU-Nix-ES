#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

git config --global user.email "you@example.com"
git config --global user.name "Your Name"


git init

git add .
git commit --message 'Save flake state'

nix flake update --recreate-lock-file

#git add .
#git commit --message 'Save flake state 2'

nix build

nix flake show

#chown --recursive --verbose pedroregispoar:wheel result \
#&& stat result \
#&& cp --no-dereference --recursive --verbose $(nix-store --query --requisites result) result2

docker load --input=./result

docker pull redis:6.0.6-alpine3.12
docker pull redis:5.0.9-buster

docker images | grep redis

docker run \
--interactive \
--rm \
--tty \
--user=somebody \
redis-minimal-non-root-user:0.0.1 \
redis-server

sudo rm --force --recursive .git result
