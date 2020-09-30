#!/usr/bin/env sh

#
## declare an array variable
#declare -a ubuntu_versions=("12.04" "13.04" "14.04" "15.04" "16.04" "17.04" "18.04" "19.04" "20.04")
#
## now loop through the above array
#for version in "${ubuntu_versions[@]}"
#do
#    docker run \
#    --interactive \
#    --rm \
#    --tty \
#    --volume "$(pwd)":/code \
#    --workdir /code \
#    ubuntu:"$version" \
#    bash -c './apt-get-install.sh sudo | head -n 1'
#done


## declare an array variable
#declare -a debian_versions=("oldoldstable-20200908-slim" "jessie-20200908-slim" "buster-20200908-slim" "bullseye-20200908-slim" "stretch-20200908-slim" "testing-20200908-slim")

declare -a debian_versions=("buster-20200908-slim")


# now loop through the above array
for version in "${debian_versions[@]}"
do
    docker run \
    --interactive \
    --rm \
    --tty \
    --volume "$(pwd)":/code \
    --workdir /code \
    debian:"$version" \
    bash -c './apt-get-install.sh sudo && ./adduser-with-sudo-privileges.sh'
done
