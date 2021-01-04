{
  description = "A description";
  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-20.09";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      #pkgs = inputs.unstable.legacyPackages.${system};
      unstable-pkgs = inputs.unstable.legacyPackages.${system};
      pkgs = inputs.stable.legacyPackages.${system};
      runtimeDeps = with pkgs; [ libspatialindex ];
      #env = pkgs.poetry2nix.mkPoetryEnv { projectDir = ./.; };
      config = {
        projectDir = ./.;
        propagatedBuildInputs = runtimeDeps;
      };

      app = unstable-pkgs.poetry2nix.mkPoetryApplication config;
      env = app.dependencyEnv; # pkgs.poetry2nix.mkPoetryEnv config;

    in {
      devShell."${system}" = pkgs.mkShell {
        #buildInputs = with pkgs; [ poetry];
        buildInputs = with pkgs; [ env
                                   direnv
                                   git
                                   gnumake
				                   kubectl
				                   python38Packages.cython
				                   libspatialindex
                                   lorri
                                   neovim
                                   poetry
                                   python39
                                 ];
      };
    };
}
