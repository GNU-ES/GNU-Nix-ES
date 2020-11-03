let
    pkgs = import <nixpkgs> {};
in
pkgs.dockerTools.buildLayeredImage {

    name = "volumes-bash-interactive";
    tag = "0.0.1";
    created = "now";

    contents = with pkgs; [
        bashInteractive
        coreutils
        which
       ];

    config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];

    config.Volumes = {
        "/data" = {};
    };
}