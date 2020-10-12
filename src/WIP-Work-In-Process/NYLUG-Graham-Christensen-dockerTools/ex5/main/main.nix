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
    contents = [
        pkgs.bashInteractive
        pkgs.coreutils (nonRootShadowSetup { uid = 999; user = "somebody"; })
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.findutils
        pkgs.git
        pkgs.nano
        pkgs.neovim
        pkgs.python39Full
        pkgs.nodejs
        pkgs.ripgrep
        pkgs.shadow
        pkgs.stdenv
        pkgs.su
        pkgs.sudo
        pkgs.texlive.combined.scheme-basic
        pkgs.wget
        pkgs.which
        pkgs.zsh
    ];
}
