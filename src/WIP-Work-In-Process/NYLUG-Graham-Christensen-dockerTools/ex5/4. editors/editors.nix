{ pkgs ? import <nixpkgs> {} }:

rec {
  editors = pkgs.dockerTools.buildImage {
    name = "editors";
    tag = "0.0.1";

    contents = [
      pkgs.coreutils
      pkgs.bash
      pkgs.vim
      pkgs.nano
    ];
  };
}