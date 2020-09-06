let
   pkgs = import <nixpkgs> {};
in pkgs.dockerTools.buildImage {
    name = "bash";
    tag = "0.0.1";
    contents = pkgs.bashInteractive;
}