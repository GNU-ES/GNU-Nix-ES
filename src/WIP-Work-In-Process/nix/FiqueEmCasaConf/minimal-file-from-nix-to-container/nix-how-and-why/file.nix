let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "minimal-derivation-example" { buildInputs = [ ]; }
  ''
    cp ${./file.txt} $out
  ''
