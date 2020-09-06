#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


nix-build ./uname-container.nix

docker load < ./result

docker run --interactive --rm --tty uname-test:0.0.1

