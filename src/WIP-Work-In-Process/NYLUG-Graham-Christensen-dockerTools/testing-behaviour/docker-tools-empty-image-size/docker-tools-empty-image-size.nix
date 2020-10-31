let
    pkgs = import <nixpkgs> {};
in

pkgs.dockerTools.buildImage {

    name = "docker-tools-empty-image-size";
    tag = "0.0.1";
    created = "now";

}