#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

EXAMPLE_DIRETORY='ex-hello'

mkdir "$EXAMPLE_DIRETORY"

cd $_

nix flake init

cat flake.nix

nix profile install .

nix develop --command 'ls'

cd ..

rm -r "$EXAMPLE_DIRETORY"

