opts:
let
   hostPkgs = import <nixpkgs> {};
   pinnedVersion = hostPkgs.lib.importJSON ./nixpkgs.json;
   pinnedPkgs = hostPkgs.fetchFromGitHub {
     owner = "NixOS";
     repo = "nixpkgs";
     inherit (pinnedVersion) rev sha256;
   };
in import pinnedPkgs opts

