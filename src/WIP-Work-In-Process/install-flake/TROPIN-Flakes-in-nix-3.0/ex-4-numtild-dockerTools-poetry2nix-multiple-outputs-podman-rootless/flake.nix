{
  description = "A usefull description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {

    packages.myExampleFlake = import ./default.nix {
      pkgs = nixpkgs.legacyPackages.${system};
    };

    packages.podman = import ./podman.nix {
      pkgs = nixpkgs.legacyPackages.${system};
    };

    defaultPackage = self.packages.${system}.podman;

    packages.${system} = self.packages.myExampleFlake;
  });

}