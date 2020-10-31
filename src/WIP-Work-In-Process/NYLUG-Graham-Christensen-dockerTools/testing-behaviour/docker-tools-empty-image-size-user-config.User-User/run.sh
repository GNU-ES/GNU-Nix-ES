#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


#TODO: inject $(git rev-parse --short HEAD) in the name

nix-build './docker-tools-empty-image-size-user-config.User-User.nix'

docker load < ./result

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
--user='12345:67890' \
docker-tools-empty-image-size-user-config.user-userr:0.0.1
#docker-tools-empty-image-size-user-config.user-user:0.0.1 'id'
