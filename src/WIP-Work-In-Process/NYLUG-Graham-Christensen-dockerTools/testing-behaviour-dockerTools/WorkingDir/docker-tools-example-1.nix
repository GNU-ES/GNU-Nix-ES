let
    pkgs = import <nixpkgs> {};
in

pkgs.dockerTools.buildImage {

    name = "docker-tools-example-1";
    tag = "0.0.1";
    created = "now";

    contents = with pkgs; [
        bashInteractive
        coreutils
        which
       ];

    config = {
        Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];
        WorkingDir = "/code2";
    };
}