# nvim ~/.config/nixpkgs/home.nix
{ config, pkgs, ... };
{
  programs.home-manager.enable = true;
  programs.bat.enable = true;
}