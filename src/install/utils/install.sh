#!/bin/bash

#APK_PACKAGE_MANAGER=${1:-'examples'}
#ls -la
#. ./utils/args-wrapper/args-wrapper.sh

echo 'Script name='$0
echo 'The number of arguments $#='$#
echo 'All arguments passed "$@"='"$@"

if command -v apt-get &> /dev/null
then
    echo 'The apt-get was detedcted!'
    ./utils/install_using_apt_get.sh 'apt-get'
fi

#
##check_apk="$(check_command_is_installed nix 10)"
##echo $check_apk
##if [ "$check_apk" = "10" ]; then
##    echo "The installer detected a this system has $program_name"
##    echo "Proceding the instalaltion."
##    ./apk-install.sh
##fi
##
##
##check_apt="$(check_command_is_installed apt 11)"
##check_apt_get="$(check_command_is_installed apt-get 12)"
##check_yum="$(check_command_is_installed yum 13)"
##check_packman="$(check_command_is_installed packman 14)"
#
#
##openssl wget xz-utils