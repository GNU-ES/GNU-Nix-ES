{ pkgs ? import <nixpkgs> {} }:

with pkgs;
  pkgs.dockerTools.buildImage {
  name = "python-test";
  tag = "0.0.1";
  created = "now";
  contents = pkgs.python3;

  config.Cmd = [ "/bin/python3" ];
}
