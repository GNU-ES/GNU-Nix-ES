#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


nix-build ./hello-output.nix

docker load < ./result

docker run --interactive --rm --tty hello-output:0.0.1
