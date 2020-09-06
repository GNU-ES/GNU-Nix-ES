#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

nix-build ./redis.nix

docker load < ./result

docker run -it bash-layered-with-user bash -c 'ls -la'
