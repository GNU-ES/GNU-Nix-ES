{ pkgs ? import <nixpkgs> {} }:

let
nonRootShadowSetup = { user, uid, gid ? uid }: with pkgs; [
  (
  writeTextDir "etc/shadow" ''
    ${user}:!:::::::
  ''
  )
  (
  writeTextDir "etc/passwd" ''
    ${user}:x:${toString uid}:${toString gid}::/home/${user}:
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
