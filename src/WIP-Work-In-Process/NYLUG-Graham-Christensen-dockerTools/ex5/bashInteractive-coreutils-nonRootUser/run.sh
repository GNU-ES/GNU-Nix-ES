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


IMAGE_VERSION='bash-interactive-coreutils-nonroot':"$VERSION"

nix-build 'bashInteractive-coreutils-nonRootUser.nix'

docker load < ./result


echo 'Testing if bash works.'
docker \
run \
--interactive \
--tty \
--user=somebody \
"$IMAGE_VERSION" -c 'ls -la'

docker \
run \
--interactive \
--tty \
--user=somebody \
"$IMAGE_VERSION" -c 'id'