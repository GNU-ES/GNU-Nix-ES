{ pkgs, ... }: {

    services.docker = {pkgs, ... }: {
        #imports = [ ../../modules/profiles/minimal.nix ];
        environment.systemPackages = [ pkgs.coreutils ];
    };

}
