{
  description = "Flake example Nix Friday";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.naersk.url = "github:nmattia/naersk";

  outputs = { self, nixpkgs, flake-utils, naersk }:
    flake-utils.lib.eachDefaultSystem (system: {
    packages.myExampleFlake = import ./. {
      pkgs = nixpkgs.legacyPackages.${system};
    };

    defaultPackage = self.packages.${system}.myExampleFlake;
  });
}