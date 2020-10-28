{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";

  networking.hostName = "fripon";
  networking.domain = "patapon.info";

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Paris";

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  services.timesyncd.enable = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    vim htop dnsutils inetutils
  ];

  users.mutableUsers = false;
  users.users.root.hashedPassword =
    "$6$IJFASoJI$7x650JQGObqKBxPhxXhmegiWED.XUmolNfwHQW1jf.2NGvWQ7uF6yh2A5Sq67Lkj.9twhoCSZkoMFqDEnDN2R.";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
