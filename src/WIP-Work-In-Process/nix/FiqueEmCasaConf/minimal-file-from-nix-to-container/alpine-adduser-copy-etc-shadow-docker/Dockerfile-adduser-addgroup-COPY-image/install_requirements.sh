#!/bin/sh


#requirements=('curl' 'openssl' 'sudo')
#missing_requirements=''
#
#missing_requirements+=' ca-certificates'
#
#if ! command -v xz &> /dev/null
#then
#    echo 'This program was not detedcted=xz'
#    missing_requirements+=' xz-utils'
#fi
#
#if ! command -v sha256sum &> /dev/null
#then
#    echo 'This program was not detedcted=sha256sum'
#    missing_requirements+=' coreutils'
#fi
#
#for program in "${requirements[@]}"
#do
#    if ! command -v "$program" &> /dev/null
#    then
#        echo 'This program was not detedcted='"$program"
#        missing_requirements+=" $program"
#    fi
#done

./apt_get_install.sh 'curl' 'openssl' 'sudo' 'coreutils' 'xz' 'ca-certificates'
