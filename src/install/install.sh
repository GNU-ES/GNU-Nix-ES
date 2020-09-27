#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

##https://stackoverflow.com/a/2013573
##https://stackoverflow.com/a/2013589
#SEARCH_PATH=${1:-'examples'}
#
## If you want debug:
## echo "$SEARCH_PATH"

./utils/install.sh
