#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

nix-build basic-example.nix

docker load < ./result

docker run --interactive --rm --tty bash:0.0.1 bash -c 'echo It is woking!'
