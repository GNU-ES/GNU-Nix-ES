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
  name = "bash-layered-with-user";
  tag = "latest";
  contents = [ pkgs.bash pkgs.coreutils (nonRootShadowSetup { uid = 999; user = "somebody"; }) ];
}