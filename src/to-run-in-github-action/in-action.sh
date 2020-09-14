#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


#echo "$(pwd)"
cd src/to-run-in-github-action/
#echo "$(pwd)"

# https://stackoverflow.com/a/10605775
FOLDER="$(find to-be-moved -mindepth 1 -maxdepth 1 -type d | cut --delimiter='/' --field=2)"
#echo DEGUG "$FOLDER"

if [ "$FOLDER" == '' ]; then
  echo "The to-be-moved folder does not have any folder."
  echo "So, nothing to do!"
else

  echo "$FOLDER"

  echo "$FOLDER" > "folder-name.txt"

#  ./check-run.sh "$FOLDER"
  #https://unix.stackexchange.com/a/132514
  var="$(./check-run.sh "$FOLDER" 2>&1)"
  echo $var

  ./commit.sh "$FOLDER"

  ./inject-revision-and-folder-name.sh "$FOLDER"

  ./move-to-examples.sh "$FOLDER"
fi
