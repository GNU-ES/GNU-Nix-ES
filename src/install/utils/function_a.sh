#!/bin/bash

set ex

echo 'Calling the function helper_function_b'

#./helper_function_b.sh 'git' 'curl'

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

#./helper_function_b.sh $missing_requirements
./apt_get_install.sh $missing_requirements
