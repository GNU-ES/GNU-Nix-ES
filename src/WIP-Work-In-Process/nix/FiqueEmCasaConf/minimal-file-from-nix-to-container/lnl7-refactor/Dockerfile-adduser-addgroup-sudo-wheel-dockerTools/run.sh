#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1
IMAGE_VERSION="$IMAGE":"$VERSION"


nix-build './nix-Luca Bruno-dockerTools.nix'

docker load < ./result

docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
--user=pedroregispoar \
gnu-nix-es:0.0.1 bash -c 'stat --format="%a" /sbin/sudo'


docker run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
gnu-nix-es:0.0.1 bash -c 'su pedroregispoar -c 'id''


#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--user='root' \
#--volume "$(pwd)":/code \
#gnu-nix-es:0.0.1 bash -c 'stat --format="%a" /nix/store/.links'
#
#
#docker run \
#--interactive \
#--tty \
#--rm \
#--workdir /code \
#--user='pedroregispoar' \
#--volume "$(pwd)":/code \
#gnu-nix-es:0.0.1 bash -c ' /nix/store/jbryisjscy1mrkfnk8zqgcqynxbvrhci-nix-2.3.6/bin/nix-env --install --attr nixpkgs.git'