{
  description = "Flake example";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.myExampleFlake = import ./. {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.myExampleFlake;
  };
}