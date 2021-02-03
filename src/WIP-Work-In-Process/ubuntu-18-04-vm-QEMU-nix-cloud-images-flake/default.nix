{ pkgs ?  import <nixpkgs> {} }:
let
  myScript = pkgs.writeShellScriptBin "helloWorld" ''
   echo Hello World!
   ${pkgs.qemu}/bin/qemu-kvm --version
   echo $(pwd)
  '';

  sshClient = pkgs.writeShellScriptBin "sshVM" ''
    sshKey=$(mktemp)
    echo "$sshKey"
  '';

in 
 
pkgs.stdenv.mkDerivation {
  name = "test-derivation";
  buildInputs = [ myScript pkgs.python39 pkgs.qemu sshClient ];
}
