# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

#let
#  pkgs = import npkgs { system = "x86_64-linux"; };
#
#  #myScript = pkgs.writeShellScriptBin "helloWorld" "echo Hello World";
#in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

#  nix = {
#    package = pkgs.nixUnstable;
#    extraOptions = ''
#      experimental-features = nix-command flakes
#    '';
#  };
 
  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     anydesk
     amazon-ecs-cli
     awscli
     curl
     direnv
     discord
     docker
     docker-compose
     firefox
     file
     #freeoffice
     gcc
     git
     gitkraken
     gnumake
     gnupg
     gparted
     #haskellPackages.pandoc
     htop
     jetbrains.pycharm-community
     keepassxc
     kdeApplications.okular
     libreoffice
     oh-my-zsh
     python38Full
     #nodejs
     #qgis
     #rubber
     spectacle
     #spotify
     tdesktop
     #tectonic
     tilix
     tree
     unrar
     unzip
     vim
     #vscode-with-extensions
     wget
     #wxmaxima
     xorg.xkill
     zsh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # https://github.com/NixOS/nixpkgs/blob/release-20.03/nixos/modules/hardware/all-firmware.nix
  hardware.enableRedistributableFirmware = true;

  # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
   
   # https://github.com/NixOS/nixpkgs/pull/44896
  # services.xserver.desktopManager = {
  #  xfce.enable = true;
  #  default = "xfce";
  #};

  services.xserver.displayManager.defaultSession = "xfce"; 

  # services.xserver.desktopManager.gnome3.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.pedro = {
     isNormalUser = true;
     extraGroups = [ "wheel" "pedro" "docker" "kvm"]; # Enable ‘sudo’ for the user.
   };

   users.extraUsers.pedro= {
     shell = pkgs.zsh;
   };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  virtualisation.docker.enable = true;
  nixpkgs.config.allowUnfree = true;  

  #virtualisation.virtualbox.host.enable = true;
  #users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  #virtualisation.virtualbox.host.enableExtensionPack = true;

  # programs.gnupg.agent.enable = true;

  # https://knowledge.rootknecht.net/nixos-configuration
  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = ''
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

    # Customize your oh-my-zsh options here
    ZSH_THEME="agnoster"

    bindkey '\e[5~' history-beginning-search-backward
    bindkey '\e[6~' history-beginning-search-forward

    HISTFILESIZE=500000
    HISTSIZE=500000
    setopt SHARE_HISTORY
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_IGNORE_DUPS
    setopt INC_APPEND_HISTORY
    autoload -U compinit && compinit
    unsetopt menu_complete
    setopt completealiases

    if [ -f ~/.aliases ]; then
      source ~/.aliases
    fi

    plugins=(
       colored-man-pages
       docker
       git
       zsh-autosuggestions
       zsh-syntax-highlighting
       )
    
    # https://keybase.pub/peterwilli/NixOS%20Shared%20Stuff/configuration.nix
    # Custom Git Commands
    # git config --global alias.ac '!git add -A && git commit' 2> /dev/null # O que isso faz?
    git config --global user.email "pedroregispoar@gmail.com" 2> /dev/null
    git config --global user.name "Pedro Regis" 2> /dev/null

    source $ZSH/oh-my-zsh.sh
  '';
  programs.zsh.promptInit = "";

  users.extraUsers.USER = {
    shell = pkgs.zsh;
  };
  
  # TODO: study about this
  # https://github.com/thiagokokada/dotfiles/blob/a221bf1186fd96adcb537a76a57d8c6a19592d0f/_nixos/etc/nixos/misc-configuration.nix#L124-L128
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

}

