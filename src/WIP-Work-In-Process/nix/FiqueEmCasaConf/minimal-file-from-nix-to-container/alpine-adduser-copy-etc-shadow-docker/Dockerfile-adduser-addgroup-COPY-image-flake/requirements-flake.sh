#!/bin/sh


#declare -a REQUIMENTS_FLAKE
#
#REQUIMENTS_FLAKE=('commons-compress-1.20' 'git-minimal-2.28.0' 'gnutar-1.32' 'nix-2.3.7' 'xz-5.2.5')
#
#NIX_ENV_QUERY=$(nix-env --query)
#
#for requirement in "${REQUIMENTS_FLAKE[@]}"
#do
#    echo '#####'"$requirement"
#    IS_IN_QUERY=false
#    for result in "${NIX_ENV_QUERY[@]}"
#    do
#        echo "$result"
#
#        if [ "$result" = "$requirement" ]; then
#            IS_IN_QUERY=true
#            echo
#        fi
#    done
#
#    if
#
#done
#
#echo "$IS_IN_QUERY"

. /home/pedroregispoar/.nix-profile/etc/profile.d/nix.sh

/home/pedroregispoar/.nix-profile/bin/nix --version
id
if ! command -v xz &> /dev/null
then
    echo "The xz was not detedcted!"
    /home/pedroregispoar/.nix-profile/bin/nix-env --install --attr \
    nixpkgs.commonsCompress
fi


if ! command -v tar &> /dev/null
then
    echo "The tar was not detedcted!"
    /home/pedroregispoar/.nix-profile/bin/nix-env --install --attr \
    nixpkgs.gnutar
fi




if ! command -v lzma &> /dev/null
then
    echo "The lzma was not detedcted!"
    /home/pedroregispoar/.nix-profile/bin/nix-env --install --attr \
    nixpkgs.lzma.bin
fi

if ! command -v git &> /dev/null
then
    echo "The git was not detedcted!"
    /home/pedroregispoar/.nix-profile/bin/nix-env --install --attr \
    nixpkgs.git
fi


#nix-env --install --attr \
#nixpkgs.commonsCompress \
#nixpkgs.gnutar \
#nixpkgs.lzma.bin \
#nixpkgs.git
