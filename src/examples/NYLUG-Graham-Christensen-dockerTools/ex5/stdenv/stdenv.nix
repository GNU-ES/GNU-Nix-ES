let
   pkgs = import <nixpkgs> {};
in pkgs.dockerTools.buildImage {
    name = "stdenv";
    tag = "0.0.1";
    contents = [
        pkgs.stdenv
        pkgs.python39Full
    ];
    config.Entrypoint = [ "${pkgs.stdenv}/bin/bash" ];
}