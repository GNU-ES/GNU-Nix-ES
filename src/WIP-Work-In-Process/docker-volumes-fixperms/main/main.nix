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

    # created = "now";

    contents = with pkgs; [
        bashInteractive
        coreutils
        findutils
        file
        man
        neovim
        ripgrep
        shadow
        stdenv
        su
        sudo
        tree
        which
        zsh
    ] ++ nonRootShadowSetup { uid = 999; user = "somebody"; };

    config.Env = [
        "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bunle.crt"
  ];
}
