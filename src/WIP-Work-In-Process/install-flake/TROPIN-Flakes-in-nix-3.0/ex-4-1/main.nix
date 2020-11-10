let
  npkgs = builtins.fetchGit {
    url = "https://github.com/nixos/nixpkgs.git";
    rev = "14006b724f3d1f25ecf38238ee723d38b0c2f4ce";
    ref = "master";
  };
in
import ./test.nix { npkgs = npkgs; }
