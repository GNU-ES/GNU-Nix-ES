{ pkgs ? import <nixpkgs> {} }:

rec {
  # 1. basic example
  bash = pkgs.dockerTools.buildImage {
    name = "bash";
    contents = pkgs.bashInteractive;
  };

  # 2. service example, layered on another image
  redis = pkgs.dockerTools.buildImage {
    name = "redis";
    tag = "0.0.1";

    # for example's sake, we can layer redis on top of bash or debian
    fromImage = bash;
    # fromImage = debian;

    contents = pkgs.redis;
    runAsRoot = ''
      mkdir -p /data
    '';

    config = {
      Cmd = [ "/bin/redis-server" ];
      WorkingDir = "/data";
      Volumes = {
        "/data" = {};
      };
    };
  };
}