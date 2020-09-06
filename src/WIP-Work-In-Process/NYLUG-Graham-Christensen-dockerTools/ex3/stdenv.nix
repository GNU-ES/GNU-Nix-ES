let
   pkgs = import <nixpkgs> {};
in pkgs.dockerTools.buildLayeredImage {
  name = "stdenv";
  tag = "0.0.1";
  config.Entrypoint = [ "${pkgs.stdenv}/bin/sh" ];
}
