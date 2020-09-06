#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


nix-build ./container-curl.nix

docker load < ./result

docker run --interactive --rm --tty uname-test:0.0.1

docker run --interactive --rm --tty curl-test:0.0.1 --help

# TODO: bring thogether a server, for example, 
# in python, a minimal http server to show that curl works
docker run --interactive --rm --tty curl-test:0.0.1 google.com
