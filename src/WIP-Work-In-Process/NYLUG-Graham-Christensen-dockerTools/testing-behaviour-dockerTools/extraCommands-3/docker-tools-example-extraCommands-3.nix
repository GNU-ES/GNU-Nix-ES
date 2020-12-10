let
    pkgs = import <nixpkgs> {};
in

pkgs.dockerTools.buildImage {

    name = "docker-tools-example-extracommands-3";
    tag = "0.0.1";
    created = "now";

    extraCommands = ''
        echo 'Some message from extraCommands echo.'

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