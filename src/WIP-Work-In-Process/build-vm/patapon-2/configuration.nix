{ config, pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.version = 2;
    boot.loader.grub.device = "/dev/vda";

    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "Europe/Paris";



    environment.systemPackages = with pkgs; [
        vim htop dnsutils inetutils
    ];

    users.mutableUsers = false;
    users.extraUsers.root.initialHashedPassword = "";
    users.users.root.hashedPassword = "";

    nix = {
        package = pkgs.nixUnstable;
        extraOptions = ''
            experimental-features = nix-command flakes
        '';
    };

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    # system.stateVersion = "18.09"; # Did you read the comment?
}
