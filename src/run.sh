#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

##https://stackoverflow.com/a/2013573
#SEARCH_PATH=${1:-'examples'}
#
## If you want debug:
## echo "$SEARCH_PATH"
#
#cd "$SEARCH_PATH"
#
#find . -name 'run.sh' -exec {} \;

for folder in $(ls examples)
do
	cd "examples/$folder"
  ./run.sh
  cd ..
done


