#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail


# TODO: use the long form of flags
# TODO: refactor this command
du -sch $(nix-store -qR $(nix-build ./danbst-python-minimal-musl.nix --no-out-link )) | sort -h


nix-store --query --references

nix-store --query --requisites

nix build github:cole-h/nixos-config/6779f0c3ee6147e5dcadfbaff13ad57b1fb00dc7#iso
du --dereference --human-readable --summarize result
nix-store --query --size result


podman run \
--interactive \
--tty \
--rm \
--workdir /code \
--volume "$(pwd)":/code \
ubuntu bash -c "sudo ls -al && id"