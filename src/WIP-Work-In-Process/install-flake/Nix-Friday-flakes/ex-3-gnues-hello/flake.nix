{
  description = "Flake example Nix Friday";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    hello.url = "github:GNU-ES/hello";
  };

  outputs = { self, nixpkgs, flake-utils, hello }:
    flake-utils.lib.eachDefaultSystem (system: {
    packages.myExampleFlake = import ./. {
      pkgs = nixpkgs.legacyPackages.${system};
    };

    defaultPackage = self.packages.${system}.myExampleFlake;
  });
}