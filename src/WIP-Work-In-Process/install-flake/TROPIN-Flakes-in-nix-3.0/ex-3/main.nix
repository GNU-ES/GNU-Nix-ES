let
  npkgs = builtins.fetchGit {
    url = "https://github.com/nixos/nixpkgs.git";
    rev = "14006b724f3d1f25ecf38238ee723d38b0c2f4ce";
    ref = "master";
  };
in
import /home/pedro/Documents/prog/GNU-Nix-ES/src/WIP-Work-In-Process/install-flake/TROPIN-Flakes-in-nix-3.0/ex-3/test.nix { npkgs = npkgs; }
