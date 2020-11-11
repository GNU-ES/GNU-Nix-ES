{
  description = "nixpkgs-review";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";

  inputs.naersk.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, naersk }:
    flake-utils.lib.eachDefaultSystem (system: {
    packages.nixpkgs-review = import ./. {
      pkgs = nixpkgs.legacyPackages.${system};
    };

    defaultPackage = self.packages.${system}.nixpkgs-review;
  });
}