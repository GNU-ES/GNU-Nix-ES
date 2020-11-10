{npkgs, ... }:
let

  # nixpkgs = <nixpkgs>;
  pkgs = import npkgs { system = "x86_64-linux"; };

  myScript = pkgs.writeShellScriptBin "helloWorld" "echo Hello World";
in
pkgs.stdenv.mkDerivation {
  name = "test-derivation";
  buildInputs = [ myScript pkgs.python38];
}
