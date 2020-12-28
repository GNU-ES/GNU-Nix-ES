#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

NIX_BASE_IMAGE='nix-base:0.0.1'

IMAGE_VERSION="$IMAGE":"$VERSION"


nix-build --attr image

docker load < ./result


#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$NIX_BASE_IMAGE" 'sudo --preserve-env ls -al && id'

#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$NIX_BASE_IMAGE" bash -c 'sudo --preserve-env ls -al && id'

#time docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$NIX_BASE_IMAGE" 'nix flake --help'

docker build \
--label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--label org.opencontainers.image.revision=$(git rev-parse $(git rev-parse --short HEAD)) \
--tag \
"$IMAGE_VERSION" .


time docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" 'sudo --preserve-env nix flake --help'

#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE_VERSION" --run 'sudo --preserve-env ls -al && id'
#
#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE_VERSION" --run 'nix flake show github:GNU-ES/hello'
#
#
#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE_VERSION"



##

#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE_VERSION" bash -c 'sudo --preserve-env nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes --run 'nix shell nixpkgs#cowsay --command cowsay "Hi from nix shell nixpkgs#cowsay!"''
#
#
##mkdir --parent "$(pwd)"/containerFolder/subFolder
#mkdir "$(pwd)"/hostFolder
#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--mount type=bind,src="$(pwd)"/hostFolder,dst=/containerFolder \
#--mount type=volume,dst="$(pwd)"/containerFolder/subFolder \
#"$IMAGE_VERSION" bash
#
#ls -al /containerFolder \
#&& mkdir /containerFolder/subFolder \
#&& ls -al /containerFolder/subFolder \
#&& touch /containerFolder/subFolder/file.txt
#
#https://stackoverflow.com/a/56334999
#
#
#mkdir "$(pwd)"/hostFolder
#
#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--volume "$(pwd)":/code \
#--mount type=bind,src=/nix/store,dst=/nix/store \
#--mount type=volume,dst=/nix/store/xwgfg65grf14vg1z05zrdy0bmnp1x007-sudo-1.8.31p1/bin \
#"$IMAGE_VERSION" bash