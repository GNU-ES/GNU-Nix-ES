{ nixpkgs ? <nixpkgs>, system ? "x86_64-linux" }:

let
  myisoconfig = { pkgs, ... }: {
    imports = [
      "${nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix"
    ];

    networking.hostName = "mynixos"; services.nginx.enable = true;
    environment.systemPackages = with pkgs; [ tmux vim ];
    users.extraUsers.root.password = "mynixos";
  };

  evalNixos = configuration: import "${nixpkgs}/nixos" {
    inherit system configuration;
  };

in { iso = (evalNixos myisoconfig).config.system.build.isoImage; }