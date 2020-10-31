{ pkgs, ... }: {

    machine = { pkgs, ... }: {
        #imports = [ ../../modules/profiles/minimal.nix ];
        environment.systemPackages = [ pkgs.coreutils ];
    };

}
