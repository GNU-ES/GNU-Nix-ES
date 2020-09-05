#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

./run.sh 'src/examples/nix/FiqueEmCasaConf/nix-gcc-9.2.0-centos-5.11'
./run.sh 'src/examples/nix/nix-in-docker/nix-install/ubuntu-12-04-adduser-nix-install-sudo'