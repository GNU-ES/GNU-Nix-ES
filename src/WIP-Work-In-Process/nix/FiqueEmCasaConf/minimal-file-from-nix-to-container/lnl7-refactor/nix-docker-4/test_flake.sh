#!/usr/bin/env sh

sudo --preserve-env nix-channel --list \
 && sudo --preserve-env nix-channel --add https://nixos.org/channels/nixos-20.09 nixos \
 && sudo --preserve-env nix-channel --list \
 && sudo --preserve-env nix-channel --update \
 && sudo --preserve-env nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs \
 && sudo --preserve-env nix-channel --update

sudo --preserve-env nix-env --install --attr \
nixpkgs.commonsCompress \
nixpkgs.gnutar \
nixpkgs.lzma.bin \
nixpkgs.git

sudo --preserve-env mkdir --parent ~/.config/nix/nix \
&& sudo --preserve-env touch /home/pedroregispoar/.config/nix/nix.conf \
&& sudo --preserve-env chown pedroregispoar:wheel /home/pedroregispoar/.config/nix/nix.conf \
&& echo 'experimental-features = nix-command flakes ca-references' >> ~/.config/nix/nix.conf

sudo --preserve-env nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix shell nixpkgs#cowsay --command cowsay "Hi from nix shell nixpkgs#cowsay!"'
