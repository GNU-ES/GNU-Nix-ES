#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

nix-build ./editors.nix

docker load < ./result

docker run --interactive --rm --tty editors:0.0.1 bash -c 'vim --version && nano --version && ls -la'
