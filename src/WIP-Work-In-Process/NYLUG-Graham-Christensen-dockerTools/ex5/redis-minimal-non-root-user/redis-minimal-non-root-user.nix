{ pkgs ? import <nixpkgs> {} }:
let
    redisMinimal = import ./redis-minimal.nix { inherit pkgs; };
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
      ''
      )
      (
      writeTextDir "etc/gshadow" ''
        root:x::
        ${user}:x::
      ''
      )
    ];
in
    pkgs.dockerTools.buildLayeredImage {    # helper to build docker image
    name = "redis-minimal-non-root-user";   # give docker image a name
    tag = "0.0.1";                          # provide a tag

    contents = with pkgs; [
#            bashInteractive
#            coreutils
#            findutils
#            man
#            neovim
            redisMinimal
#            ripgrep
#            stdenv
#            which
    ] ++ nonRootShadowSetup { uid = 999; user = "somebody"; };
}
