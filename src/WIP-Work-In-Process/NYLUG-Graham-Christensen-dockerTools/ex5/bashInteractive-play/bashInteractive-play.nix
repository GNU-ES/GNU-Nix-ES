let
    pkgs = import <nixpkgs> {};

  testFile = pkgs.writeText "test.conf" ''
    some data
  '';
  test = pkgs.writeShellScriptBin "test" ''
    set -e

    ${pkgs.coreutils}/bin/cat ${testFile}
    ${pkgs.coreutils}/bin/ls -l ${testFile}
    ${pkgs.utillinux}/bin/hexdump ${testFile}
  '';
in

pkgs.dockerTools.buildLayeredImage {

  name = "test";
  tag = "latest";
  contents = test;
  config = {
    Cmd = [ "/bin/test" ];
  };
}