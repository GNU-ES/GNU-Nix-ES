let
  pkgs = import <nixpkgs> {};
in pkgs.fetchurl {
  url = "http://grahamc.com";
  sha256 = "1dxxk2apm36pgdqyrr4iyk32crzw9mbfqrhl03wszl0qwys00a2w";
}
