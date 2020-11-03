#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


# TODO: use the long form of flags
# TODO: refactor this command
du -sch $(nix-store -qR $(nix-build ./danbst-python-minimal-musl.nix --no-out-link )) | sort -h
