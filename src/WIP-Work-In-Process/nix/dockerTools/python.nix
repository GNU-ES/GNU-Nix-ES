{ pkgs ? import <nixpkgs> {} }:

with pkgs;
  pkgs.dockerTools.buildImage {
  name = "python3-nix";
  tag = "latest";
  created = "now";
  contents = pkgs.python3;

  config.Cmd = [ "/bin/python3" ];
}

