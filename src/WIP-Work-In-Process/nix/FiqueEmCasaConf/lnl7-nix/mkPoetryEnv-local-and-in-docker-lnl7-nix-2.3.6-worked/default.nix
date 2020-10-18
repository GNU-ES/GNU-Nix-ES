
with import <nixpkgs> {};
let
  env = poetry2nix.mkPoetryEnv {
    python = python3;
    pyproject = ./pyproject.toml;
    poetrylock = ./poetry.lock;
  };
in
runCommand "env-test"
{ } ''
  mkdir $out
  cp ${env}/bin/python $out
  ls -al $out
''
