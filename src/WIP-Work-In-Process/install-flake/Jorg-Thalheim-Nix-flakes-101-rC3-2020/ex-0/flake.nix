{
  description = "Hello world";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
        packages.x86_64-linux.example = pkgs.stdenv.mkDerivation {
            name = "example";
            src = self;
            installPhase = ''
                mkdir --parent $out/bin
                install --mode=755 example.sh $out/bin/example
            '';
        };
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.example;
  };
}
