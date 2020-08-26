FROM lnl7/nix:2.3.6

RUN nix-env --install --attr nixpkgs.commonsCompress nixpkgs.gnutar nixpkgs.lzma.bin nixpkgs.git

RUN mkdir -p ~/.config/nix/nix \
 && echo 'experimental-features = nix-command flakes ca-references' >> ~/.config/nix/nix.conf

# Why there is no long form of the flag -I in `nix-shell -I` ?
RUN sh -c 'nix-shell -I nixpkgs=channel:nixos-20.03 --packages nixFlakes'

CMD ["nix-shell", "-I", "nixpkgs=channel:nixos-20.03", "--packages", "nixFlakes"]
