let
  pkgs = import <nixpkgs> {};
  
  src = pkgs.fetchurl {
    url = "http://grahamc.com";
    sha256 = "1dxxk2apm36pgdqyrr4iyk32crzw9mbfqrhl03wszl0qwys00a2j";
  };
  
  slow = pkgs.runCommand "slow" {} ''
    sleep 100
    touch $out
  '';
  
in pkgs.runCommand "build-with-dependency" {} ''
  mkdir $out
  cp ${./talk.md} $out/talk.md
  cp ${src} $out/source
  cp ${slow} $out/slow
''
