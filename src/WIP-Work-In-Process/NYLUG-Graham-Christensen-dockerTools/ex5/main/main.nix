{ pkgs ? import <nixpkgs> {} }:

let
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
pkgs.dockerTools.buildLayeredImage {
    name = "main";
    tag = "0.0.1";
    contents = with pkgs; [
        bashInteractive
        coreutils (nonRootShadowSetup { uid = 999; user = "somebody"; })
        curl
        gnutar
        xz
        findutils
        git
        man
        nano
        neovim
        python39Full
        nodejs
        ripgrep
        shadow
        stdenv
        su
        sudo
        texlive.combined.scheme-basic
        wget
        which
        zsh
    ];
}
