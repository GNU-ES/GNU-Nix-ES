#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

cd to-be-moved

# https://stackoverflow.com/a/10605775
FOLDER_NAME="$(find . -mindepth 1 -maxdepth 1 -type d | cut --delimiter='/' --field=2)"

if [ -n $FOLDER_NAME ]; then
  echo "The FOLDER_NAME variable is empt."
  echo "So, nothing to move!"
else
  echo "Moving "$FOLDER_NAME" to examples."
  mv "$FOLDER_NAME" ../../examples/
fi
