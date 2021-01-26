#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


git init

git config user.email "you@example.com"
git config user.name "Your Name"

git add .

git commit --message 'Save flake state'

nix flake update --commit-lock-file

#nix build --out-link oci_image
#nix build


#cp --no-dereference --recursive --verbose $(nix-store --query --requisites oci_image) oci_image_out \
#&& mv oci_image_out oci_image

nix develop --command podman --help

nix build .#myExampleFlake

#NEWUIDMAP=$(readlink --canonicalize $(which newuidmap))
#NEWGIDMAP=$(readlink --canonicalize $(which newgidmap))
#
#sudo setcap cap_setuid+ep "$NEWUIDMAP"
#sudo setcap cap_setgid+ep "$NEWGIDMAP"
#
#sudo chmod -s "$NEWUIDMAP"
#sudo chmod -s "$NEWGIDMAP"
#
#
#cat << EOF > policy.json
#{
#    "default": [
#        {
#            "type": "insecureAcceptAnything"
#        }
#    ],
#    "transports":
#        {
#            "docker-daemon":
#                {
#                    "": [{"type":"insecureAcceptAnything"}]
#                }
#        }
#}
#EOF



nix develop --command ./test_podman-rootless-wrapper.sh


sudo rm --force --recursive .git flake.lock result oci_image
