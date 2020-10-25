#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

TARGET_0='builder'
TARGET_1='prod'

IMAGE_VERSION_TARGET_0="$IMAGE""$TARGET_0":"$VERSION"
IMAGE_VERSION_TARGET_1="$IMAGE""$TARGET_1":"$VERSION"


nix-build './nix-Luca Bruno-dockerTools.nix'

docker load < ./result


docker build \
--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
--target "$TARGET_1" \
--tag "$IMAGE_VERSION_TARGET_1" .


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
--user=pedroregispoar \
"$IMAGE_VERSION_TARGET_1" sh -c 'stat --format="%a" $(which sudo)'


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
--user=pedroregispoar \
"$IMAGE_VERSION_TARGET_1" sh -c 'git --version'

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
--user=pedroregispoar \
"$IMAGE_VERSION_TARGET_1" sh -c 'nix --version'