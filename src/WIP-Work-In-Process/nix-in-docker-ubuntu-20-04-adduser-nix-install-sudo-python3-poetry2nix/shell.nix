{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.python38Full
      pkgs.poetry
    ];
  shellHook = ''
        # https://python-poetry.org/docs/configuration/
        export POETRY_VIRTUALENVS_CREATE=false
    '';
}
