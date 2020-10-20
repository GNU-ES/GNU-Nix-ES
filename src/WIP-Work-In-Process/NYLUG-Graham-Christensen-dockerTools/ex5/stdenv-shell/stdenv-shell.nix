let
    pkgs = import <nixpkgs> {};
in
pkgs.dockerTools.buildLayeredImage {

    name = "stdenv-shell";
    tag = "0.0.1";
    created = "now";

    contents = with pkgs; [
        bashInteractive
        stdenv.shell
        which
       ];

    config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];
}