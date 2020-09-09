#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

cd my-flake

nix profile install .

nix develop --command 'ls'

