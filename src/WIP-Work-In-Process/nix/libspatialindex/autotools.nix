pkgs: attrs:
  with pkgs;
  let defaultAttrs = rec {
    version = "1.8.5";

    builder = "${bash}/bin/bash";
    args = [ ./builder.sh ];
    baseInputs = [ findutils gnutar gzip gnumake gcc binutils-unwrapped coreutils gawk gnused gnugrep patchelf ];
    buildInputs = [];
    system = builtins.currentSystem;
  };
  in
  derivation (defaultAttrs // attrs)