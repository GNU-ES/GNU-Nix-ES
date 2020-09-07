fetchurl ? (import <nixpkgs> {}).fetchurl

fetchurl {
    url = "https://raw.githubusercontent.com/PedroRegisPOAR/Teste-06-07-2016/master/readme-images/github-octocat.png"
    name = "myimage"
    sha256 = "08vqyjc6bs56gzb5m3247i6mc92d9gsrlanwsr7ji9hrrckws9fj"
}