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

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
--user=pedroregispoar \
alpine-gnu-nix-es:0.0.1 bash -c 'stat --format="%a" /sbin/sudo'


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
alpine-gnu-nix-es:0.0.1 bash -c 'su pedroregispoar -c 'id''


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--user='pedroregispoar' \
--volume "$(pwd)":/code \
alpine-gnu-nix-es:0.0.1 bash -c 'stat --format="%a" /sbin/sudo'

