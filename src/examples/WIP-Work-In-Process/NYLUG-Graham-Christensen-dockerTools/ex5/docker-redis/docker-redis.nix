{ pkgs ? import <nixpkgs> {} }:         # nixpkgs package set

pkgs.dockerTools.buildLayeredImage {    # helper to build docker image
    name = "nix-redis";                 # give docker image a name
    tag = "0.0.1";                      # provide a tag
    contents = [ pkgs.redis ];          # packages in docker image
}
