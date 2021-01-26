{ pkgs ?  import <nixpkgs> {} }:
let
  myScript = pkgs.writeShellScriptBin "mywhich" ''
    #!${pkgs.stdenv.shell}
    echo 'The wrapper!'
    ${pkgs.which}/bin/which "$@"
  '';
in
pkgs.stdenv.mkDerivation {
  name = "test-derivation";
  buildInputs = with pkgs; [ myScript
          conmon
          podman
          runc
          shadow
          slirp4netns
        ];
}
