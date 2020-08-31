let
   pkgs = import <nixpkgs> {};
   hello-output = pkgs.runCommand "hello" { buildInputs = [ pkgs.hello ]; }
   ''
     mkdir $out
     hello > $out/hello
   ''
in pkgs.dockerTool.buidLayeredImage {
  name = "hello-data";
  tag = '0.0.1';
  contents = [ hello-out ];
}
