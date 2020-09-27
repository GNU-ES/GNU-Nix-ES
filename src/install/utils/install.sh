#!/bin/bash

#APK_PACKAGE_MANAGER=${1:-'examples'}

ls -la

. ./utils/args-wrapper/args-wrapper.sh

#check_command_is_installed() {
#
#    program_name="$1"
#    return_code="$2"
#
#    if command -v ${program_name} &> /dev/null
#    then
#        echo "Command ${program_name} found!"
#        # TODO: run a scrip that install some thing
#        # (first check if this thing is being used and is installed using nix)
#        # if not, install it and after that uninstall it.
#        # using nix and test this thing, after that
#    else
#        echo "Command ${program_name} NOT found!"
#        echo "The return code was: $return_code"
#        return "$return_code"
#    fi
#}
#
#if command -v apk &> /dev/null
#then
#    install-using-apk.sh 'apk'
#fi
#
if command -v apt &> /dev/null
then
    echo 'The apt was detedcted!'
    ./utils/install-using-apt.sh 'apt'
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