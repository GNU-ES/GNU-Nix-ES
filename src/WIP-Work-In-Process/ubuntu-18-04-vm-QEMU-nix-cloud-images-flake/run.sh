#!/usr/bin/env nix-shell
#!nix-shell -i bash
set -euo pipefail


#if [ $# -eq 0 ]
#  then
#    rm --force --verbose disk.qcow2 userdata.qcow2
#fi

#./wootbuntu


nix develop  --command helloWorld
