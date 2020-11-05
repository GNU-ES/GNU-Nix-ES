let
    pkgs = import <nixpkgs> {};
in
    pkgs.dockerTools.buildLayeredImage {
        name = "bash-interactive";
        tag = "0.0.1";
        created = "now";

        contents = with pkgs; [
            bashInteractive
           ];

        config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];
    }
