#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"


nix-build --attr image

docker load < ./result

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c "sudo ls -al && id"


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'sudo su -c 'env''


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'sudo --preserve-env su -c 'env''


docker build --tag "$IMAGE_VERSION" .


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c 'sudo ls -al'



docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c 'sudo --preserve-env nix-env --file "<nixpkgs>" --install --attr hello --show-trace && hello'


docker run \
--interactive \
--privileged \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c 'sudo --preserve-env nix-build --attr image && stat result && sudo chown --recursive --verbose pedroregispoar:pedroregispoar result && stat result && cp --no-dereference --recursive --verbose $(nix-store --query --requisites result) result2'


docker load < ./result2

docker build --tag "$IMAGE_VERSION" .


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c 'sudo ls -al'



docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c './test_nixos.iso_minimal.x86_64-linux.sh'


docker run \
--interactive \
--privileged \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" bash -c './test_flake.sh'


#docker run \
#--interactive \
#--privileged \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE_VERSION" bash -c 'NIXOS_CONFIG="$(pwd)"/configuration.nix sudo --preserve-env nix-build "<nixpkgs/nixos>" --attr vm --verbose --show-trace'
##"$IMAGE_VERSION" bash -c 'sudo --preserve-env nix-build "<nixpkgs/nixos>" --attr vm --arg configuration ./configuration.nix --show-trace'


#docker run \
#--interactive \
#--privileged \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#--volume '/nix/store':'/nix/store' \
#nix-base:0.0.1 bash
