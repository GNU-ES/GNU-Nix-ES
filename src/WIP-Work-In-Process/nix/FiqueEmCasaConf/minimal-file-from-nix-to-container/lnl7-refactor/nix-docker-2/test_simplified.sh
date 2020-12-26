#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

TARGET_0='builder'
TARGET_1='prod'

IMAGE_VERSION_TARGET_0="$IMAGE""$TARGET_0":"$VERSION"
IMAGE_VERSION_TARGET_1="$IMAGE""$TARGET_1":"$VERSION"


nix-build --attr image

docker load < ./result

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c "sudo --preserve-env ls -al && id"

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c 'sudo --preserve-env nix-env --file "<nixpkgs>" --install --attr hello --show-trace && hello'

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
nix-base:0.0.1 bash -c "sudo --preserve-env nix-env --file '<nixpkgs>' --install --attr gnugrep --show-trace && sudo --preserve-env nix show-derivation nixpkgs.sudo | grep '04755'"

#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#nix-base:0.0.1 bash -c 'sudo --preserve-env nix-build --attr image && stat result && sudo chown --recursive --verbose pedroregispoar:pedroregispoar result && stat result && cp --no-dereference --recursive --verbose $(nix-store --query --requisites result) result2'

#docker load < ./result2
#
#docker build --tag "$IMAGE_VERSION" .
#
#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE_VERSION" bash -c 'sudo ls -al'


#mkdir /home/pedro/.config/containers/
#touch /home/pedro/.config/containers/policy.json

#https://nixos.wiki/wiki/Podman
#{
#"default": [
#{
#"type": "insecureAcceptAnything"
#}
#],
#"transports":
#{
#"docker-daemon":
#{
#"": [{"type":"insecureAcceptAnything"}]
#}
#}
#}

#podman load < ./result
#
#podman run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#nix-base:0.0.1 bash




#docker build --tag "$IMAGE_VERSION" .
#
#
#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE_VERSION" bash -c 'sudo --preserve-env ls -al  && id'
#
#
#
#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE_VERSION" bash -c 'sudo --preserve-env nix-env --file "<nixpkgs>" --install --attr hello --show-trace && hello'
