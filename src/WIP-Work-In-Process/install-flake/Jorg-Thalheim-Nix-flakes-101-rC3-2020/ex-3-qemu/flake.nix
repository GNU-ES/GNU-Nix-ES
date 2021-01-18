{
  description = "Test QEMU";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
        packages.x86_64-linux.myqemu = pkgs.qemu;
        defaultPackage.x86_64-linux = self.packages.x86_64-linux.myqemu;
  };
}
