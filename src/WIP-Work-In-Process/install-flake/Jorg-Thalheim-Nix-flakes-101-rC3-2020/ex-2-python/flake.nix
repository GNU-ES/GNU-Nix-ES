{
  description = "Hello world";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
        packages.x86_64-linux.example = pkgs.python39;
        defaultPackage.x86_64-linux = self.packages.x86_64-linux.example;
  };
}
