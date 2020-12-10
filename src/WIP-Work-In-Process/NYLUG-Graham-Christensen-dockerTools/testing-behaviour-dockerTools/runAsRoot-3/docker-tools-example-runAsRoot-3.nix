let
    pkgs = import <nixpkgs> {};
in

pkgs.dockerTools.buildImage {

    name = "docker-tools-example-runasroot-3";
    tag = "0.0.1";
    created = "now";

    runAsRoot = ''
        echo 'Some mensage from runAsRoot echo.'

        touch file.txt
        chmod 1777 file.txt

        echo $(id)
    '';

    contents = with pkgs; [
        bashInteractive
        coreutils
        which
        findutils
        file
    ];

    config = {
        Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];
    };
}