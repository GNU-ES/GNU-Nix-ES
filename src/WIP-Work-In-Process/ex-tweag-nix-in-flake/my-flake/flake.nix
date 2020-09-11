{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs-channels/nixos-unstable";
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-20.03";
      flake = false;
    };
    home.url = github:rycee/home-manager/bqv-flakes;
    nur.url = github:nix-community/NUR;
  };

  outputs = { nixpkgs, nix, self, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        (import ./configuration.nix)
        inputs.home.nixosModules.home-manager
      ];
      specialArgs = { inherit inputs; };
    };
    legacyPackages.x86_64-linux = self.nixosConfigurations.nixos.pkgs;
  };
}