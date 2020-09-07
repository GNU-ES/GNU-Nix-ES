
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "minimal-derivation-example" { buildInputs = [ ]; }
  ''  
    cp ${./my-input-data-file.txt} $out
  ''

