#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

IMAGE='gnu-nix-es/debian-slim-nix-install'
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

#docker run \
#--interactive \
#--tty \
#--rm \
#"$IMAGE_VERSION" sh -c "nix --version && nix-env --install --attr nixpkgs.python39 && python --version && python -c 'print(12345)'"
#
#docker run \
#--interactive \
#--rm \
#--tty \
#--volume "$(pwd)":/code \
#debian:buster-slim \
#bash -c "source ./code/install.sh && nix --version"
#
#docker run \
#--interactive \
#--privileged \
#--rm \
#--tty \
#--volume "$(pwd)":/code \
#--volume /var/run/docker.sock:/var/run/docker.sock \
#"$IMAGE_VERSION" \
#bash --command "docker images"

docker run \
--rm \
"$IMAGE_VERSION" sh -c "nix --version && nix-env --install --attr nixpkgs.python39 && python --version && python -c 'print(12345)'"

docker run \
--rm \
--volume "$(pwd)":/code \
debian:buster-slim \
bash -c "source ./code/install.sh && nix --version"

docker run \
--privileged \
--rm \
--volume "$(pwd)":/code \
--volume /var/run/docker.sock:/var/run/docker.sock \
"$IMAGE_VERSION" \
bash --command "docker images"
