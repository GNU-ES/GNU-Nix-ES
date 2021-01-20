{ pkgs ?  import <nixpkgs> {} }:
let
    redisMinimal = import ./redis-minimal.nix { inherit pkgs; };
in
    pkgs.dockerTools.buildLayeredImage {    # helper to build docker image
    name = "nix-redis-dockertools";             # give docker image a name
    tag = "0.0.1";                          # provide a tag
    contents = [ pkgs.redis ];              # use redis package
}