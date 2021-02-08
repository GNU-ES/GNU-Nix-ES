{ pkgs ? import <nixpkgs> { } }:
let
  #pkgs = pkgs;

in pkgs.runCommand "hello" { buildInputs = with pkgs; [ hello ]; }
  ''
    mkdir --parent $out

    cp -arv ${pkgs.hello}/bin/hello $out/hello
  ''
