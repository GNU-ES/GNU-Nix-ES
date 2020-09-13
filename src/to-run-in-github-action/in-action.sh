#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

./check-run.sh

./inject-revision-and-folder-name.sh

./move-to-examples.sh
