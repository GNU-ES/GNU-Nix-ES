{ pkgs ? import <nixpkgs> { } }:
with pkgs;
mkShell {
  buildInputs = [
    nixpkgs-fmt
    python39
  ];

  shellHook = ''
    echo 'Hello, you are in the nix shell!'
    export MY_ENVIRONMENT_VARIABLE='123GNU-Nix-ES'
  '';
}