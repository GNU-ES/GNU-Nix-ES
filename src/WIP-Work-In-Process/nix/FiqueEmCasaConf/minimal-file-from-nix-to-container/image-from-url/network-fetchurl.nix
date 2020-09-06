let
  pkgs = import <nixpkgs> {};
in pkgs.fetchurl {
  url = "https://raw.githubusercontent.com/PedroRegisPOAR/Teste-06-07-2016/master/readme-images/github-octocat.png";
  sha256 = "08vqyjc6bs56gzb5m3247i6mc92d9gsrlanwsr7ji9hrrckws9fj";
}
