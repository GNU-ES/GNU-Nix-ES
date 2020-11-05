#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


#TODO: inject $(git rev-parse --short HEAD) in the name

LOG_FILE='log.log'
nix-build './docker-tools-example-1.nix' > "$LOG_FILE"

cat "$LOG_FILE" | grep 'Some mensage from extraCommands echo.'

#if [[  ]]; then
#
#else
#    exit 42
#fi

rm "$LOG_FILE"
