{ pkgs ?  import <nixpkgs> {} }:

with pkgs;
let
  newPackage = stdenv.mkDerivation {
    name = python39.name;
    buildCommand = ''
      mkdir $out
      cp -r ${python39}/* $out/
      chmod +w -R $out
      find $out | grep -e test -e tkinter -e idle | xargs rm -rf
      find $out -type f | xargs sed -i "s|${python39}|$out|g"
      find $out -type l | grep -v -e "include/python" | while read link; do
        ln -sf $(readlink -f $link | sed "s|${python39}|$out|g") $link
      done

      #unlink $out/include/python3.7
      #ln -sf $out/include/python3.7m $out/include/python3.7

      # TODO: why it works?! Check PATH and all the closure,
      # is possible filter only symbolic links using the
      # https://nixos.org/manual/nix/stable/#examples-16
      # nix-store -q --graph ~/.nix-profile | dot -Tps > graph.ps

      #ln -sf $out/include/python3 $out/include/python
      #ln -sf $out/include/python3m $out/include/python3
    '';
  };
in newPackage