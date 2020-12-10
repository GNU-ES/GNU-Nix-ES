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
        ${user}:x:${toString uid}:${toString gid}::/home/${user}:${runtimeShell}
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
    runAsRoot = ''
        #!${pkgs.stdenv.shell}
        ${pkgs.dockerTools.shadowSetup}
        # usermod -aG sudo somebody
        # chown root:root $(readlink $(which su))
        # chmod 1755 $(readlink $(which su))
    '';

shadowOverrided = pkgs.shadow.override { pam = null; };

in
pkgs.dockerTools.buildLayeredImage {
    name = "bash-layered-with-user-with-sudo";
    tag = "0.0.1";
    contents = with pkgs; [
    bashInteractive
    coreutils
    curl
    gnutar
    xz
    findutils
    git
    man
    neovim
    ripgrep
    shadowOverrided
    stdenv
    su
    sudo
    pam
    wget
    which
    ] ++ nonRootShadowSetup { uid = 999; user = "somebody"; };

}