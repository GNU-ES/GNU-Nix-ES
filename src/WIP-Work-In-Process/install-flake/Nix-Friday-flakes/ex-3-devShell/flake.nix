{
  description = "Flake example Nix Friday";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.naersk.url = "github:nmattia/naersk";

  outputs = { self, nixpkgs, flake-utils, naersk }:
    flake-utils.lib.eachDefaultSystem (system: let
      #pkgs = nixpkgs.legacyPackages.${system};
    in rec {
    packages.myExampleFlake = import ./. {
      pkgs = nixpkgs.legacyPackages.${system};
    };

    defaultPackage = self.packages.${system}.myExampleFlake;

    #devShell = pkgs.mkShell {
    #    # supply the specific rust version
    #    nativeBuildInputs = [ pkgs.hello ];
    #};
  }
  );
}