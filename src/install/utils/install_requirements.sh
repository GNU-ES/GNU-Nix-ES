#!/bin/bash


requirements=('curl' 'openssl' 'sudo')
missing_requirements=''

missing_requirements+=' ca-certificates'

if ! command -v xz &> /dev/null
then
    echo "The xz was not detedcted!"
    missing_requirements+=' xz-utils'
fi

for program in "${requirements[@]}"
do
    if ! command -v "$program" &> /dev/null
    then
        echo 'This program was not detedcted='"$program"
        missing_requirements+=" $program"
    fi
done

./utils/apt_get_install.sh $missing_requirements
