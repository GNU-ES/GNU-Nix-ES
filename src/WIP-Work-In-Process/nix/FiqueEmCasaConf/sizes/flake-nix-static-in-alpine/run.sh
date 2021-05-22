#!/usr/bin/env sh
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

#./build-as-root.sh
#./test-as-root.sh

./build-non-root.sh
./build-non-root-scratch.sh

#./test-non-root.sh
#./test-non-root-scratch.sh


#nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#{\
#gcc10,\
#gcc6,\
#gfortran10,\
#gfortran6,\
#julia,\
#nodejs,\
#poetry,\
#python39,\
#rustc,\
#yarn\
#}
#'
#
#gcc --version
##gcc6 --version
#gfortran10 --version
#gfortran6 --version
#julia --version
#nodejs --version
#poetry --version
#python3 --version
#rustc --version
#yarn --version