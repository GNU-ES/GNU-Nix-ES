#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


nix-build ./hello-test.nix

docker load < ./result

docker run --interactive --rm --tty hello-test:0.0.1



nix-build ./python-test.nix

docker load < ./result

docker run --interactive --rm --tty python-test:0.0.1 '--version'