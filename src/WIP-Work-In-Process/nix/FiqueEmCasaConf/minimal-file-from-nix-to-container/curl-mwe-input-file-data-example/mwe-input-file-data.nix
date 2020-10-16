
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "minimal-derivation-example" { buildInputs = [ ]; }
  ''
    mkdir $out
    cp ${./my-input-data-file.txt} $out/my-input-data-file.txt
  ''

