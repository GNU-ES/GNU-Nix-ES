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

      # TODO: make it work. What is the sintax?
      #packages.x86_64-linux.myattr = myExampleFlake;
      #defaultPackage = self.packages.${system}.myExampleFlake;

      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [ postman ];
      };

    }
  );

}