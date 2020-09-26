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
#find . -name 'run.sh' -exec {} \;

#echo "$(pwd)"
#ls -la
cd ..
./utils/end-mensage.sh