let
    pkgs = import <nixpkgs> {};
in

pkgs.dockerTools.buildImage {

    name = "docker-tools-empty-image-size-user-config.user-user";
    tag = "0.0.1";
    created = "now";

    #config.User = "12345";
    config.User = "12345:67890";

    #contents = with pkgs; [
    #    coreutils
    #];
}