#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
# TODO: use this and check how to correctly use variable number of arguments in bash
set -euxo pipefail

nix-build ./redis.nix

docker load < ./result-2

docker run --interactive --rm --tty redis:0.0.1 bash -c 'echo It is woking!'
