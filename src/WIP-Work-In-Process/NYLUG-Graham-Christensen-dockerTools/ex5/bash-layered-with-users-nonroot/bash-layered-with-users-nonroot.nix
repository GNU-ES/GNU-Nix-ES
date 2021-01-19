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
  name = "bash-layered-with-user";
  tag = "latest";
  contents = [ pkgs.bash pkgs.coreutils (nonRootShadowSetup { uid = 999; user = "somebody"; }) ];
}
