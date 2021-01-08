{ pkgs ? import <nixpkgs> { } }: rec {
  myHello = pkgs.dockerTools.buildLayeredImage {
    name = "bash-entrypoint";
    tag = "latest";
    contents = [ pkgs.bash ];
    config.Entrypoint = [ "${pkgs.bash}/bin/bash" ];
  };
}
