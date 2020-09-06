{ pkgs ? import <nixpkgs> {} }:
let
  pythonEnv = pkgs.poetry2nix.mkPoetryEnv {
  python = pkgs.python3;
  poetrylock = ./poetry.lock;
  mkDerivation = import ./autotools.nix pkgs;
  };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.python3
      pkgs.poetry
      pythonEnv
    ];
}
