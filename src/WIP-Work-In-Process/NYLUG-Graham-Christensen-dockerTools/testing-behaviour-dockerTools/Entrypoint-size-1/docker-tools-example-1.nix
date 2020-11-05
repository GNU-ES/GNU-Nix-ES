let
    pkgs = import <nixpkgs> {};

    entrypoint = pkgs.writeScript "entrypoin-file.sh" ''
        ${pkgs.coreutils}/bin/ls
    '';
in

pkgs.dockerTools.buildImage {

    name = "docker-tools-example-1";
    tag = "0.0.1";
    created = "now";

    config = {
        Entrypoint = [ entrypoint ];
    };
}