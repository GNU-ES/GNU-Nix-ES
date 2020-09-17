#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -eux pipefail


IMAGE_VERSION="gnu-nix-es/$(git rev-parse --short HEAD)":"0.0.1"


docker build \
--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
--tag \
"$IMAGE_VERSION" .


docker run \
--interactive \
--rm \
--tty \
--user root \
--volume "$(pwd)":/code \
--workdir /code \
"gnu-nix-es/$(git rev-parse --short HEAD)":"0.0.1" \
bash

# TODO:
# use sudo tee etc to save the output
sphinx-quickstart \
--author GNU-Nix-ES \
--language en \
--project GNU-Nix-ES \
--release 0.0.0

make html

#sudo chown --recursive "$(id --user)":"$(id --group)" .
