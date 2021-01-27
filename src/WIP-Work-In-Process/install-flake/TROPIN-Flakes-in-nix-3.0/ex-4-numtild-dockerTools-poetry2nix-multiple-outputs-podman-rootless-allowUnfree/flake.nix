{
  description = "A usefull description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let

        pkgsAllowUnfree = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };

        #packages.myExampleFlake = import ./default.nix {
        #  pkgs = nixpkgs.legacyPackages.${system};
        #};
        #packages.myExampleFlake = import ./default.nix { pkgs = self.pkgs; };

      in
      {
        # For free packages use:
        #packages.podman = import ./podman.nix {
        #    pkgs = nixpkgs.legacyPackages.${system};
        #};

        packages.podman = import ./podman.nix {
          pkgs = pkgsAllowUnfree;
        };

        defaultPackage = self.packages.${system}.podman;

        packages.poetry2nixOCIImage = import ./default.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };
        packages.${system} = self.packages.poetry2nixOCIImage;
      });

}
