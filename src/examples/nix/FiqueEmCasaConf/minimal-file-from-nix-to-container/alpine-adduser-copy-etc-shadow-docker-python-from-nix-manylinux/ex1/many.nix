# https://sid-kap.github.io/posts/2018-03-08-nix-pipenv.html

let
  pkgs = import <nixpkgs> {};
  manyLinuxFile =
    pkgs.writeTextDir "_manylinux.py"
      ''
        print("in _manylinux.py")
        manylinux1_compatible = True
      '';
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # All the C libraries that a manylinux_1 wheel might depend on:
    ncurses
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libICE
    xorg.libSM
    glib
  ];

  extraOutputsToInstall = [ "dev" ];
  
  shellHook = ''
    export PYTHONPATH=${manyLinuxFile.out}:$PYTHONPATH
    unset SOURCE_DATE_EPOCH
  '';
}

