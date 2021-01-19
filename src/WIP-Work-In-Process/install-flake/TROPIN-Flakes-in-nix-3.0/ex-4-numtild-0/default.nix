{ pkgs ?  import <nixpkgs> {} }:
let
  myScript = pkgs.writeShellScriptBin "helloWorld" "echo Hello World";
in
pkgs.stdenv.mkDerivation {
  name = "test-derivation";
  buildInputs = [ myScript pkgs.python39];
}
