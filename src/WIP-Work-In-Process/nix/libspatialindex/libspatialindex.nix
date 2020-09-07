let
  pkgs = import <nixpkgs> {};
  mkDerivation = import ./autotools.nix pkgs;
  version = "1.8.5";
in mkDerivation {
  name = "libspatialindex";
  src = pkgs.fetchurl {
  url = "https://download.osgeo.org/libspatialindex/spatialindex-src-${version}.tar.gz";
  sha256 = "1vxzm7kczwnb6qdmc0hb00z8ykx11zk3sb68gc7rch4vrfi4dakw";
  };
}