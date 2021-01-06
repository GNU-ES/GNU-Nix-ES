#!/usr/bin/env sh


#sudo --preserve-env nix-env --file "<nixpkgs>" --install --attr \
#commonsCompress \
#gnutar \
#lzma.bin \
#git

sudo --preserve-env mkdir --parent ~/.config/nix/nix \
&& sudo --preserve-env touch /home/pedroregispoar/.config/nix/nix.conf \
&& sudo --preserve-env chown pedroregispoar:wheel /home/pedroregispoar/.config/nix/nix.conf \
&& echo 'experimental-features = nix-command flakes ca-references' >> ~/.config/nix/nix.conf
