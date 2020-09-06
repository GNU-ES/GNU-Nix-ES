let
  pkgs = import <nixpkgs> {};
  mkDerivation = import ./autotools.nix pkgs;
in mkDerivation {
  name = "hello3";
  src = ./hello-2.10.tar.gz;
}