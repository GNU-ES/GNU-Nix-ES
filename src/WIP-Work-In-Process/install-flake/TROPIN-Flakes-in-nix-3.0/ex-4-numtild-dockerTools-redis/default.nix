{ pkgs ?  import <nixpkgs> {} }:
pkgs.dockerTools.buildLayeredImage {    # helper to build docker image
  name = "nix-redis-dockertools";       # give docker image a name
  tag = "0.0.1";                        # provide a tag
  contents = [ pkgs.redis ];            # use redis package
}