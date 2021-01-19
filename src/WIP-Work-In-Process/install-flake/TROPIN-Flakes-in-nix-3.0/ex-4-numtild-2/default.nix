{ pkgs ?  import <nixpkgs> {} }:
let
  myScript = pkgs.writeShellScriptBin "mywhich" ''
    #!${pkgs.stdenv.shell}
    echo 'The wrapper!'
    ${pkgs.which}/bin/which "$@"
  '';
in
pkgs.stdenv.mkDerivation {
  name = "test-derivation";
  buildInputs = [ myScript pkgs.python39 pkgs.qemu];
}
