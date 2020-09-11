#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail

IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1
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
#--rm \
#--tty \
#--user pedro \
#"$IMAGE_VERSION" \
#bash -c "nix --version && nix-env --install --attr nixpkgs.python39 && python --version && python -c 'print(12345)'"

docker run \
--tty \
--user pedro \
"$IMAGE_VERSION" \
bash -c "nix --version && nix-env --install --attr nixpkgs.python39 && python --version && python -c 'print(12345)'"
