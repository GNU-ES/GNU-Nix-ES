#!/bin/sh


sudo mkdir -m 0755 /nix \
 && sudo chown pedroregispoar /nix \
 && sudo curl -L https://nixos.org/nix/install | sh \
 && echo '. /home/pedroregispoar/.nix-profile/etc/profile.d/nix.sh' >> /home/pedroregispoar/.bashrc \
 && /home/pedroregispoar/.nix-profile/bin/nix-env --install --attr \
    nixpkgs.commonsCompress \
    nixpkgs.gnutar \
    nixpkgs.lzma.bin \
    nixpkgs.git \
 && /home/pedroregispoar/.nix-profile/bin/nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes