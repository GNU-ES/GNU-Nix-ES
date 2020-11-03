{ pkgs, config, ... }: {

    users = {
        extraUsers.root.initialHashedPassword = "";
        mutableUsers = false;

         extraUsers.pedro= {
            shell = pkgs.zsh;
            extraGroups = [ "root" ];
            };
    };

    nix = {
        package = pkgs.nixUnstable;
        extraOptions = ''
            experimental-features = nix-command flakes
        '';
    };
}
