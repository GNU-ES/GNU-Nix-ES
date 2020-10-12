#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
# TODO: use this and check how to correctly use variable number of arguments in bash
#set -euxo pipefail

IMAGE_NIX_FILE=${1:-'python3-test.nix'}
IMAGE_NAME=${1:-'python3-test'}
ARGS_1=${3:-'--version'}
#ARGS_2=${4:-"-c "print("Hello GNU-Nix-ES")""}
TAG=${5:-'0.0.1'}

nix-build ./$IMAGE_NIX_FILE

docker load < ./result

docker run "$IMAGE_NAME":"$TAG" "$ARGS_1"

#docker run "$IMAGE_NAME":"$TAG" "$ARGS_2"
