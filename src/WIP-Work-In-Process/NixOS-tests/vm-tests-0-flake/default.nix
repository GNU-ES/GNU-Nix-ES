{ pkgs ? import <nixpkgs> { } }:
let
    test = pkgs.nixosTest ./test.nix;
in
  test
