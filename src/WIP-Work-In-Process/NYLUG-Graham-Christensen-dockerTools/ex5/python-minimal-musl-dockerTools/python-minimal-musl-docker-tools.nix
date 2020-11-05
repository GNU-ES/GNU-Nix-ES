{ pkgs ? import <nixpkgs> {} }:
let
    pythonMinimalmusl = import ./python-minimal-musl.nix { inherit pkgs; };
in
    pkgs.dockerTools.buildImage {
        name = "python-minimal-musl";
        tag = "0.0.1";
        contents = [ pythonMinimalmusl ];
    }
