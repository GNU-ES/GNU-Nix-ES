{ pkgs ? import <nixpkgs> { } }:
let
  poetry2nixOCIImage = import ./poetry2nix.nix { inherit pkgs; };
in
pkgs.dockerTools.buildLayeredImage {
  name = "numtild-dockertools-poetry2nix";
  tag = "0.0.1";
  contents = [ poetry2nixOCIImage ];
}
