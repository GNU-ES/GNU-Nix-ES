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
    name = "mix";
    tag = "0.0.1";
    contents = [
        pkgs.bashInteractive
        pkgs.coreutils (nonRootShadowSetup { uid = 999; user = "somebody"; })
        pkgs.findutils
        pkgs.home-manager
        pkgs.nano
        pkgs.neovim
        # pkgs.nix
        # pkgs.nodePackages.npm
        pkgs.python39Full
        # pkgs.rubber
        pkgs.ripgrep
        pkgs.shadow
        pkgs.stdenv
        pkgs.which
        pkgs.zsh
    ];
}