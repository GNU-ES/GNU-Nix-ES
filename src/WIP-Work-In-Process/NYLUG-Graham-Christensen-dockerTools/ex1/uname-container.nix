let
   pkgs = import <nixpkgs> {};
in pkgs.dockerTools.buildLayeredImage {
  name = "uname-test";
  tag = "0.0.1";
  config.Cmd = [ "${pkgs.busybox}/bin/uname" ];
}
