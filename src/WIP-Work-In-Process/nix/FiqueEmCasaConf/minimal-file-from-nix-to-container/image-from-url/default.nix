with import <nixpkgs> {};
stdenv.mkDerivation rec {
  pname = "octocat";
  version = "0.0.1";

  src = fetchurl {
    url = "https://raw.githubusercontent.com/PedroRegisPOAR/Teste-06-07-2016/master/readme-images/github-octocat.png";
    sha256 = "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i";
  };

  doCheck = true;
}
