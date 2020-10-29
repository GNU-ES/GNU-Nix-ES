let
    pkgs = import <nixpkgs> {};

    nonRootShadowSetup = { user, uid, gid ? uid }: with pkgs; [
          (
          writeTextDir "etc/shadow" ''
            root:!x:::::::
            ${user}:!:::::::
          ''
          )
          (
          writeTextDir "etc/passwd" ''
            root:x:0:0::/root:${runtimeShell}
            ${user}:x:${toString uid}:${toString gid}::/home/${user}:
          ''
          )
          (
          writeTextDir "etc/group" ''
            root:x:0:
            ${user}:x:${toString gid}:
            sudo:x:27:
          ''
          )
          (
          writeTextDir "etc/gshadow" ''
            root:x::
            ${user}:x::
            sudo:x::
          ''
          )
        ];
in

pkgs.dockerTools.buildImage {

    name = "docker-tools-example-1";
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
    ] ++ nonRootShadowSetup { uid = 999; user = "somebody"; };

    config = {
        Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];
    };
}