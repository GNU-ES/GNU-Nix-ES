#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

echo "$(pwd)"
cd src/to-run-in-github-action/
echo "$(pwd)"
#."$(pwd)"/to-run-in-github-action/check-run.sh

FOLDER="$(find to-be-moved -mindepth 1 -maxdepth 1 -type d | cut --delimiter='/' --field=2)"
#echo DEGUG "$FOLDER"

if [ -n "$FOLDER_NAME" ]; then
  echo "The to-be-moved folder is empty."
  echo "So, nothing to move!"
else

  echo "$FOLDER"

  ./check-run.sh "$FOLDER"

  ./inject-revision-and-folder-name.sh "$FOLDER"

  ./move-to-examples.sh "$FOLDER"
fi
