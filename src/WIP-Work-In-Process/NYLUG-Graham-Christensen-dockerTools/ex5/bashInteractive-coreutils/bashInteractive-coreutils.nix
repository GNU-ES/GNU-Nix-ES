let
    pkgs = import <nixpkgs> {};
in
pkgs.dockerTools.buildLayeredImage {

    name = "bash-interactive-coreutils";
    tag = "0.0.1";
    created = "now";

    contents = with pkgs; [
        bashInteractive
        coreutils
        which
       ];

    config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];
}