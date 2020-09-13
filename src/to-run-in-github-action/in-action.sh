#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

##https://stackoverflow.com/a/2013573
##https://stackoverflow.com/a/2013589
#SEARCH_PATH=${1:-'examples'}
#
## If you want debug:
## echo "$SEARCH_PATH"
#
#cd "$SEARCH_PATH"
#
#find . -name 'README.md' -exec {} \;

#find . -name 'README.md' -exec cat {} \;

#| sed 's/WORD3/\n&/g;s/\(WORD1\)[^\n]*\n/\1 foo /g'




#find . -name 'README.md' -exec {} \;

##echo "$(pwd)"
##ls -la
#for folder in src/examples/*
#do
#	cd "$folder"
#  ./run.sh
#  cd -
#
##  ls -la
##  echo "$folder"
#
#done
#
#
#./src/utils/end-mensage.sh
