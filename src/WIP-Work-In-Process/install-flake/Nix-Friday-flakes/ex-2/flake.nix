{
  description = "Example of flake using flake-utils.";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
    packages.myExampleFlake = import ./. {
      pkgs = nixpkgs.legacyPackages.${system};
    };

    defaultPackage = self.packages.${system}.myExampleFlake;
  });
}