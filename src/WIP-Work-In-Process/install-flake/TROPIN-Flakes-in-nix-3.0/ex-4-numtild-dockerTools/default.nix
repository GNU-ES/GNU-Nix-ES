{ pkgs ?  import <nixpkgs> {} }:
let
  myScript = pkgs.writeShellScriptBin "mywhich" ''
    #!${pkgs.stdenv.shell}
    echo 'The wrapper!'
    ${pkgs.which}/bin/which "$@"
  '';
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
  tag = "0.0.1";
  #contents = [ myScript pkgs.bashInteractive pkgs.coreutils (nonRootShadowSetup { uid = 999; user = "somebody"; }) ];
  contents = [ pkgs.bashInteractive ];
}