#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -eux pipefail

IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

# Why export does not work?
#export IMAGE_VERSION="$IMAGE":"$VERSION"
IMAGE_VERSION="$IMAGE":"$VERSION"


docker build \
--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
--tag \
"$IMAGE_VERSION" .

# Usefull for debug:
# echo -e " "'"$ENV->"'"$ENV\n" '"$NIX_PATH"->'"$NIX_PATH\n" '"$PATH"->'"$PATH\n" '"$USER"->' "$USER\n"


#docker run \
#--interactive \
#--tty \
#--user pedro \
#--volume "$(pwd)":/code \
#--workdir /code \
#"$IMAGE_VERSION" --run "nix-shell --run './test_install-of-flask.sh'"

# TODO: do a simpligfied version using ls -la
#--run "nix-shell --run 'ls -la'"

docker run \
--interactive \
--tty \
--rm \
--user pedro \
--volume "$(pwd)":/code \
--workdir /code \
"$IMAGE_VERSION" nix-shell --run './test_install-of-flask.sh'

#../.././utils/end-mensage.sh
