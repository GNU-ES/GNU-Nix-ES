with import <nixpkgs> {};
let
  newPackage = stdenv.mkDerivation {
    name = python3.name;
    buildCommand = ''
      mkdir $out
      cp -r ${python3}/* $out/
      chmod +w -R $out
      find $out | grep -e test -e tkinter -e idle | xargs rm -rf
      find $out -type f | xargs sed -i "s|${python3}|$out|g"
      find $out -type l | grep -v -e "include/python" | while read link; do
        ln -sf $(readlink -f $link | sed "s|${python3}|$out|g") $link
      done
      unlink $out/include/python3.8/python3.8m
      ln -sf $out/include/python3.8m $out/include/python3.8
    '';
  };
in newPackage
