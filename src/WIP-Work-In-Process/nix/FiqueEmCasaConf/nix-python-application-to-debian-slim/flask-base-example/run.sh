#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail

IMAGE='gnu-nix-es/ex4-flake-python'
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"

docker build --tag "$IMAGE_VERSION" .

#docker run \
#--interactive \
#--tty \
#--rm \
#"$IMAGE_VERSION" --run 'nix flake show github:GNU-ES/hello'


#docker run \
#--interactive \
#--tty \
#--rm \
#"$IMAGE_VERSION" bash -c 'python --version && gcc --version'


#ls -la home/pedro/. \
#nix-env --query \
#echo "$NIX_PATH" \
#ls /nix/var/nix/profiles/per-user/pedro/profile/bin/ \
#ls nix/store/ | grep python \
#ls nix/store/2nwf8wih4b7z4yvyyc57d78kzgz96lck-python3-3.9.0a4/ \
#ls nix/store/2nwf8wih4b7z4yvyyc57d78kzgz96lck-python3-3.9.0a4/bin/ \
#ls nix/store/2nwf8wih4b7z4yvyyc57d78kzgz96lck-python3-3.9.0a4/bin/python3.9 \


#echo "$NIX_PATH"
#
#la -la /nix/var/nix/profiles/per-user/pedro/channels
#
#la -la /home/pedro/.nix-defexpr/channels
#
#ls /nix/var/nix/profiles/per-user/pedro/channels/nixpkgs
#
#echo "$PATH"
#
#ls /home/pedro/.nix-profile/bin





