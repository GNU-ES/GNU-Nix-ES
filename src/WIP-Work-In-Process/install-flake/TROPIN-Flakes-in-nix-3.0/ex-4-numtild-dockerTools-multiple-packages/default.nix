{ pkgs ?  import <nixpkgs> {} }:

pkgs.dockerTools.buildLayeredImage {    # helper to build docker image
  name = "nix-dockertools-multiple-packages";       # give docker image a name
  tag = "0.0.1";                        # provide a tag
  contents = with pkgs; [ hello figlet ];

  config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];

}
