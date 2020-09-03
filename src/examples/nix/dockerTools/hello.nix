{ pkgs ? import <nixpkgs> {} }:

with pkgs;
  pkgs.dockerTools.buildImage {
  name = "hello";
  tag = "latest";
  created = "now";
  contents = pkgs.hello;

  config.Cmd = [ "/bin/hello" ];
}

