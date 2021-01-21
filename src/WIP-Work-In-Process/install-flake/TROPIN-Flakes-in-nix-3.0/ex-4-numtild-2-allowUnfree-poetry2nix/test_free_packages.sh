#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail



nix develop --ignore-environment --command make --version


nix develop --ignore-environment --command aws --version


nix develop --ignore-environment --command http --version

nix develop --ignore-environment --command terraform --version

nix develop --ignore-environment --command codium --version

nix develop --ignore-environment --command node --version
nix develop --ignore-environment --command podman --version

# Via ssh it was showing a big warning
#nix develop --ignore-environment --command keepassxc --version


nix develop --ignore-environment --command python --version

nix develop --ignore-environment --command python -c 'import flask'
