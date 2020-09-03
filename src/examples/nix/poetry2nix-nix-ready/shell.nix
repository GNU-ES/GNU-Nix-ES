{ pkgs ? import <nixpkgs> {} }:
let
  pythonEnv = pkgs.poetry2nix.mkPoetryEnv {
  python = pkgs.python3;
  poetrylock = ./poetry.lock;
  };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.python3
      pkgs.poetry
      pythonEnv
    ];

#    shellHook = ''
#        # https://python-poetry.org/docs/configuration/
#        export POETRY_VIRTUALENVS_CREATE=false
#    '';

}
