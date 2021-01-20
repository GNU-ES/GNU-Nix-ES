{
  description = "A usefull description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      };
      myExampleFlake = import ./default.nix {
      pkgs = pkgs;
    };
    in
    {
      packages.myExampleFlake = myExampleFlake;

      defaultPackage = self.packages.${system}.myExampleFlake;
    }


  );

}