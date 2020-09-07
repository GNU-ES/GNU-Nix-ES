{ pkgs ? import <nixpkgs> {} }:
pkgs.poetry2nix.mkPoetryApplication {
    python = pkgs.python3;
    pyproject = ./pyproject.toml;
    src = pkgs.lib.cleanSource ./.;
}