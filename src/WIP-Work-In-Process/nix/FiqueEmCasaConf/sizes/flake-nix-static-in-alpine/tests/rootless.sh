

nix --version

/nix/store/*-nix*/bin/nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run id
