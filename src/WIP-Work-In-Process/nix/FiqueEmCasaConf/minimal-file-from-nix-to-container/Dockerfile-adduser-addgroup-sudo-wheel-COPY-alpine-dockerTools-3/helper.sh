#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


#nix-env --install --attr nixos.skopeo nixos.jq
#nix-env --install --attr nixpkgs.skopeo nixpkgs.jq
#nix shell nixpkgs#{skopeo,jq}

#https://github.com/NixOS/nixpkgs/commit/42a0b11450948fd83b45e1ee60c252f8b9e84e81#r28956897
IMAGE_NAME='nixos/nix:2.2.1'
TARGZ_DIRETORY='/tmp/tmp.tgz'


#fd6472552945aef2fced5f0d1bddbfe752188423
debug()
{
  skopeo copy docker://"$IMAGE_NAME" docker-archive://"$TARGZ_DIRETORY":"$IMAGE_NAME"
  echo 'nix-hash:'
  nix-hash --base32 --flat --type sha256 "$TARGZ_DIRETORY"
  echo 'skopeo'
  skopeo inspect docker://docker.io/"$IMAGE_NAME" | jq -r '.Digest'
}

#rm  "$TARGZ_DIRETORY"
