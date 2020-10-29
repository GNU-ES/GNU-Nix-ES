let
    pkgs = import <nixpkgs> {};
in

pkgs.dockerTools.buildImage {

    name = "docker-tools-example-1";
    tag = "0.0.1";
    created = "now";

    extraCommands = ''
        echo 'Some mensage from extraCommands echo.'
    '';

    contents = with pkgs; [
        bashInteractive
        coreutils
        which
       ];

    config = {
        Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];
    };
}