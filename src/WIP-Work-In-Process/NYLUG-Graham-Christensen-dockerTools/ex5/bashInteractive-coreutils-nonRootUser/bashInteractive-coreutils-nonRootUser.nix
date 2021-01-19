let
    pkgs = import <nixpkgs> {};
    nonRootShadowSetup = { user, uid, gid ? uid }: with pkgs; [
      (
      writeTextDir "etc/shadow" ''
        ${user}:!:::::::
      ''
      )
      (
      writeTextDir "etc/passwd" ''
        ${user}:x:${toString uid}:${toString gid}::/home/${user}:${runtimeShell}
      ''
      )
      (
      writeTextDir "etc/group" ''
        ${user}:x:${toString gid}:
      ''
      )
      (
      writeTextDir "etc/gshadow" ''
        ${user}:x::
      ''
      )
    ];
in
pkgs.dockerTools.buildLayeredImage {

    name = "bash-interactive-coreutils-nonroot";
    tag = "0.0.1";
    created = "now";

    contents = with pkgs; [
        bashInteractive
        coreutils
    ] ++ nonRootShadowSetup { uid = 999; user = "somebody"; };

    config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];
}