let
    pkgs = import <nixpkgs> {};
in

with pkgs;

stdenv.mkDerivation {
    name = "hello-world";
    verison = "0.0.1";

    src = ./.;

    buildPhase = ''
    gcc main.c
    '';
    installPhase = ''
    mkdir --parent $out/bin
    cp a.out $out/bin/hello
    '';
}