#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


./inject-revision-and-folder-name.sh ../examples "$(cat folder-name.txt)"

rm -rf folder-name.txt
