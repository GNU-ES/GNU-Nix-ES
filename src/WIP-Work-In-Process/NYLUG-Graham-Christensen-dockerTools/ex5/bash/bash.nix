let
    pkgs = import <nixpkgs> {};
in
pkgs.dockerTools.buildLayeredImage {
  name = "bash-entrypoint";
  tag = "latest";
  contents = [ pkgs.bash ];
  config.Entrypoint = [ "${pkgs.bash}/bin/bash" ];
}