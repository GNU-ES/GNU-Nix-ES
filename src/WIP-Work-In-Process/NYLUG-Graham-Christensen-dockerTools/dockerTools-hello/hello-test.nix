{ pkgs ? import <nixpkgs> {} }:

with pkgs;
  pkgs.dockerTools.buildImage {
  name = "hello-test";
  tag = "0.0.1";
  created = "now";
  contents = pkgs.hello;

  config.Cmd = [ "/bin/hello" ];
}

