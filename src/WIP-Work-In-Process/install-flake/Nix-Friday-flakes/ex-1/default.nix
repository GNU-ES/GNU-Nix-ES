{ pkgs ?  import <nixpkgs> {} }:

with pkgs;
let
  newPackage = stdenv.mkDerivation {
    name = python39.name;
    buildCommand = ''
      mkdir $out
      cp -r ${python36}/* $out/
      chmod +w -R $out
      find $out | grep -e test -e tkinter -e idle | xargs rm -rf
      find $out -type f | xargs sed -i "s|${python3}|$out|g"
      find $out -type l | grep -v -e "include/python" | while read link; do
        ln -sf $(readlink -f $link | sed "s|${python3}|$out|g") $link
      done

      # TODO: check why it was in this way in the comment in the issue
      #unlink $out/include/python3
      #ln -sf $out/include/python3m $out/include/python3

      ln -sf $out/include/python3 $out/include/python
      ln -sf $out/include/python3m $out/include/python3
    '';
  };
in newPackage