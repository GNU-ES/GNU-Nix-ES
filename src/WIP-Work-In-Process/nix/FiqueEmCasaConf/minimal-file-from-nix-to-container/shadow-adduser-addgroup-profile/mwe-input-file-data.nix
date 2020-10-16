
let
  pkgs = import <nixpkgs> {};
   # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/docker/examples.nix
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
in pkgs.runCommand "minimal-derivation-example" { buildInputs = [ nonRootShadowSetup { uid = 999; user = "somebody"; } ]; }
  ''
    mkdir $out
    cp -r (nonRootShadowSetup { uid = 999; user = "somebody"; }) $out/minimal-derivation-example
  ''

