{ pkgs ? import <nixpkgs> {} }:
let
    pythonEnv = pkgs.poetry2nix.mk {
        python = pkgs.python3;
        poetrylock = ./poetry.lock;
    };
  pkgs.mkShell {
    buildInputs = [ pkgs.poetry pythonEnv];

}
