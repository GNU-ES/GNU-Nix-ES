#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
# TODO: use this and check how to correctly use variable number of arguments in bash
#set -euxo pipefail

IMAGE_NIX_FILE=$1
IMAGE_NAME=$2
ARGS=$3


nix-build ./$IMAGE_NIX_FILE

docker load < ./result

docker run $IMAGE_NAME:0.0.1 $ARGS
