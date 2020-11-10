let
  npkgs = builtins.fetchGit {
  url = "https://github.com/nixos/nixpkgs.git";
  rev = "e43b443121b43ab7abf13ba2a99607cfd8cf7656";
  ref = "master";
  };
in
import /home/pedro/Documents/prog/GNU-Nix-ES/src/WIP-Work-In-Process/install-flake/TROPIN-Flakes-in-nix-3.0/ex-2/test.nix { npkgs = npkgs; }
