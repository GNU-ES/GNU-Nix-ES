{
  description = "nixpkgs-review";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.naersk.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, naersk }:
    flake-utils.lib.eachDefaultSystem (system: {
    packages.nixpkgs-review = import ./. {
      pkgs = nixpkgs.legacyPackages.${system};
    };


    defaultPackage = self.packages.${system}.nixpkgs-review;
  });
}