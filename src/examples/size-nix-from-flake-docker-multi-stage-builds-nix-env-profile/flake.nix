{
  description = "A very basic flake";

  outputs = { self, nixpkgs}: {

    packages.x86_64-linux.nix = nixpkgs.legacyPackages.x86_64-linux.nix;

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.nix;

  };
}
