let
    pkgs = import <nixpkgs> {};
in
pkgs.dockerTools.buildLayeredImage {
  name = "bash-minimal";
  tag = "0.0.1";
  contents = with pkgs; [ bash coreutils];
  #config.Entrypoint = [ "${pkgs.coreutils}/bin/ls" ];
  config.Entrypoint = [ "${pkgs.bash}/bin/bash" ];
}