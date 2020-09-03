{ pkgs ? import <nixpkgs> {} }:
pkgs.poetry2nix.mkPoetryApplication {
    poetrylock = ./poetry.lock;
    pyproject = ./pyproject.toml;
    python = pkgs.python3;
    src = pkgs.lib.cleanSource ./.;

    overrides = [
        pkgs.poetry2nix.defaultPoetryOverrides
        (self: super: {
            flask = super.flask.overrideAttrs(old: {
                preConfigure = ''
                    ${pkgs.cowsay}/bin/cowsay "Moooo"
                    sleep 2
                '';
            });
        })
    ];
}