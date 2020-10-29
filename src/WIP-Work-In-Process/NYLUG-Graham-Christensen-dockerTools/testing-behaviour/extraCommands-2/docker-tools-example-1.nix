let
    pkgs = import <nixpkgs> {};
in

pkgs.dockerTools.buildImage {

    name = "docker-tools-example-1";
    tag = "0.0.1";
    created = "now";

    extraCommands = ''
        echo 'Some mensage from extraCommands echo.'
        echo $(pwd)
        ls -al

        mkdir --parent tmp/test1

        mkdir --parent --mode=0775 tmp/test2
        touch file.txt

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