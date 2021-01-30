#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE="gnu-nix-es/$(git rev-parse --short HEAD)"
VERSION=0.0.1

IMAGE_VERSION="$IMAGE":"$VERSION"


sudo --preserve-env --set-home mkdir --mode=755 "$HOME"/.local
sudo mkdir --mode=755 --parent /nix/var/nix/profiles

sudo --preserve-env --set-home chown --recursive pedroregispoar:pedroregispoargroup \
  /tmp \
  /nix/var/nix \
  /nix/var/nix/profiles \
  /nix/var/nix/temproots \
  "$HOME"/ \
    --verbose

sudo chmod 755 /nix/store
sudo chmod 755 /nix/var/nix
sudo chmod 755 /nix/var
sudo chmod 755 /nix/var/nix/temproots
sudo chmod 755 /tmp
sudo chmod 755 "$HOME"
sudo chmod 755 "$HOME"/.local


cd /nix/store \
&& sudo find /nix/store ! -path '*sudo*' -exec chown pedroregispoar:pedroregispoargroup {} --verbose \; \
&& cd -

cd "$HOME" \
&& sudo find "$HOME" ! -path '*sudo*' -exec chown pedroregispoar:pedroregispoargroup {} --verbose \; \
&& cd -

nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix flake show github:GNU-ES/hello'
