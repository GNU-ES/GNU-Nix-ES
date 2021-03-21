#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


nix-build ./danbst-python-minimal.nix

du \
--human-readable \
--summarize \
--total \
$(nix-store --query --requisites result) | sort --human-numeric-sort

nix-build ./danbst-python-minimal.nix

file $(readlink result/bin/python)

result/bin/python --version

rm --force result
