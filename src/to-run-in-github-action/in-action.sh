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
#  https://unix.stackexchange.com/a/132514
#  var="$(./check-run.sh "$FOLDER" 2>&1)"
#  echo $var

  ./check-run.sh "$FOLDER"
  exit_code=$?
  echo 'The exite code:'$exit_code
  if [ $exit_code -eq 0 ] || [ $exit_code -eq 1 ] ; then
    echo 'The ./run.sh seens to have worked correcly.'
    echo 'The current diretory is: '"$(pwd)"
    ls -la
    ./inject-revision-and-folder-name.sh 'examples\/'"$FOLDER"
    ls -la
    ./move-to-examples.sh "$FOLDER"
  else
    echo 'The ./run.sh may have failed.'
    echo 'Inject revision for failed.'
    ./inject-revision-and-folder-name.sh 'broken\/'"$FOLDER"
    echo 'Moving to broken folder.'
    ./move-to-examples.sh "$FOLDER" broken
  fi
fi
