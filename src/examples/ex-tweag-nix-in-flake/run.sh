#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE="gnu-nix-es/"$(basename "$(pwd)")""
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"


docker build \
--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
--tag \
"$IMAGE_VERSION" .


#docker run \
#--interactive \
#--tty \
#--rm \
#"$IMAGE_VERSION" --run 'nix flake show github:GNU-ES/hello'


# TODO:
#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE_VERSION" --run './my-flake/tweag-tutorial.sh'

#sudo rm -r my-flake


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" --run 'nix flake --version && cd imgapp/ && nix build && ls result/bin/'


