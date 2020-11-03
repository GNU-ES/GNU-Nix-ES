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
        usermod -aG sudo somebody
        chown root:root /sbin/sudo
        chmod 4755 /sbin/sudo
    '';


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
    shadow
    stdenv
    su
    sudo
    wget
    which
    ] ++ nonRootShadowSetup { uid = 999; user = "somebody"; };

}