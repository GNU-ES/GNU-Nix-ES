let
    pkgs = import <nixpkgs> {};

    nonRootShadowSetup = with pkgs; [
          (
          writeTextDir "etc/shadow" ''
            root:!x:::::::
          ''
          )
          (
          writeTextDir "etc/passwd" ''
            root:x:0:0::/root:${runtimeShell}
          ''
          )
          (
          writeTextDir "etc/group" ''
            root:x:0:
          ''
          )
          (
          writeTextDir "etc/gshadow" ''
            root:x::
          ''
          )
        ];
in

pkgs.dockerTools.buildImage {

    name = "docker-tools-example-runasroot-2";
    tag = "0.0.1";
    created = "now";

    runAsRoot = ''
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
        sudo
        pam
    ] ++ nonRootShadowSetup;

    config = {
        Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];
    };
}