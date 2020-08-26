{
  description = "A home flake";

  inputs = {
    system = "x86_64-linux";
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.03;
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = nixpkgs.system.legacyPackages.x86_64-linux;

    defaultPackage.x86_64-linux = with self.packages.x86_64-linux; buildEnv {
      name = "home-env";
      paths = [ python3 ];
    };
    legacyPackages.x86_64-linux = nixpkgs.system.legacyPackages.x86_64-linux;
  };
}