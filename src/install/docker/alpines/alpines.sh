#!/bin/sh

#https://stackoverflow.com/a/8880633
### declare an array variable
#declare -a alpine_versions=("3.1"
#                "3.1"
#                "3.1")
#
### now loop through the above array
#for i in "${arr[@]}"
#do
#   echo "$i"
#   # or do whatever with individual element of the array
#done

#for version in $(seq 1 12)
#do
##    echo "Welcome $i times"
#    docker run \
#    --rm \
#    alpine:3."$version" \
#    sh -c "apk --version"
#done

# declare an array variable
declare -a ubuntu_versions=("12.04" "13.04" "14.04" "15.04" "16.04" "17.04" "18.04" "19.04" "20.04")

# now loop through the above array
for version in "${ubuntu_versions[@]}"
do
    docker run \
    --rm \
    ubuntu:"$version" \
    bash -c 'apt-get --version | head -n 1'
done
