#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail




sudo --preserve-env nix-env --file "<nixpkgs>" --install --attr git --show-trace \
&& git clone https://github.com/nixos/nixpkgs.git \
&& cd nixpkgs \
&& git checkout 3bc15cbb5524a5607c842a7a1acc494e5729f697 \
&& sudo --preserve-env nix-build ./nixos/release-combined.nix --attr nixos.iso_minimal.x86_64-linux --verbose \
&& sudo chown --recursive --verbose pedroregispoar:pedroregispoar result \
&& stat result \
&& cp --no-dereference --recursive --verbose $(nix-store --query --requisites result) result3/


#git clone https://github.com/nixos/nixpkgs.git \
#&& cd nixpkgs \
#&& git checkout 3bc15cbb5524a5607c842a7a1acc494e5729f697 \
#&& nix-build ./nixos/release-combined.nix --attr nixos.iso_minimal.x86_64-linux --verbose
#
#nix-collect-garbage --delete-old