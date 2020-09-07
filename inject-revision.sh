#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

#cd src/examples
#
#find . -name 'user-run.sh' -exec sed --expression="s:REVISION:$(git rev-parse $(git rev-parse --short HEAD)):g" --in-place  {} +
#

function substitute_BLOCK_with_FILEcontents {
  local BLOCK_StartRegexp="${1}"
  local BLOCK_EndRegexp="${2}"
  local FILE="${3}"
  sed -e "/${BLOCK_EndRegexp}/a ___tmpMark___" -e "/${BLOCK_StartRegexp}/,/${BLOCK_EndRegexp}/d" | sed -e "/___tmpMark___/r ${FILE}" -e '/___tmpMark___/d'
}



#find . -name 'README.md' -exec substitute_BLOCK_with_FILEcontents {} +



#https://stackoverflow.com/a/15849152
#https://unix.stackexchange.com/a/12904
#https://www.everythingcli.org/find-exec-vs-find-xargs/
