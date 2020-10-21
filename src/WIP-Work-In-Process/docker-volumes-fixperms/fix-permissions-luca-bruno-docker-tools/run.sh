#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"


#docker build \
#--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
#--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
#--tag \
#"$IMAGE_VERSION" .
#
#docker run \
#--interactive \
#--tty \
#--rm \
#--user pedro \
#"$IMAGE_VERSION" \
#sh


nix-build './fix-permissions-luca-bruno-docker-tools.nix'

docker load < ./result

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
fix-permissions-luca-bruno-docker-tools:0.0.1 \
bash -c 'id'


#