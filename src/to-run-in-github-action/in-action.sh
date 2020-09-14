#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

echo "$(pwd)"
cd src/to-run-in-github-action/
echo "$(pwd)"
#."$(pwd)"/to-run-in-github-action/check-run.sh
./check-run.sh

./inject-revision-and-folder-name.sh

./move-to-examples.sh
