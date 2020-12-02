with import <nixpkgs> {};
let
  newPackage = stdenv.mkDerivation rec {
    pname = "toybox";
    version = "0.8.3";

    pkgs = import <nixpkgs> {};

    src = fetchFromGitHub {
    owner = "landley";
    repo = pname;
    rev = version;
    sha256 = "0cb1n0skanwwkwgzlswwhvfb4iji1bw9iqskmczlhakpw3j1yaqa";
    };

    # https://github.com/NixOS/nixpkgs/blob/a371c1071161104d329f6a85d922fd92b7cbab63/pkgs/top-level/static.nix#L130
    enableStatic = true;

    # https://github.com/NixOS/nixpkgs/blob/39769df9dfa63263850e9c4f6f771873b89198b5/pkgs/os-specific/linux/busybox/sandbox-shell.nix#L6
    enableMinimal = true;
    buildInputs = lib.optionals enableStatic [ stdenv.cc.libc stdenv.cc.libc.static ];

    postPatch = "patchShebangs .";

    inherit (pkgs) extraConfig;
    passAsFile = [ "extraConfig" ];

    configurePhase = ''
    make ${if enableMinimal then
      "allnoconfig"
    else
      if stdenv.isFreeBSD then
        "freebsd_defconfig"
      else
        if stdenv.isDarwin then
          "macos_defconfig"
        else
          "defconfig"
    }
    cat $extraConfigPath .config > .config-
    mv .config- .config
    make oldconfig
    '';

    makeFlags = [ "PREFIX=$(out)/bin" ] ++ lib.optional enableStatic "LDFLAGS=--static";

    installTargets = [ "install_flat" ];

    # tests currently (as of 0.8.0) get stuck in an infinite loop...
    # ...this is fixed in latest git, so doCheck can likely be enabled for next release
    # see https://github.com/landley/toybox/commit/b928ec480cd73fd83511c0f5ca786d1b9f3167c3
    #doCheck = true;
    checkInputs = [ which ]; # used for tests with checkFlags = [ "DEBUG=true" ];
    checkTarget = "tests";

    NIX_CFLAGS_COMPILE = "-Wno-error";

    meta = with stdenv.lib; {
    description = "Lightweight implementation of some Unix command line utilities";
    homepage = "https://landley.net/toybox/";
    license = licenses.bsd0;
    platforms = with platforms; linux ++ darwin ++ freebsd;
    maintainers = with maintainers; [ hhm ];
    priority = 10;
    };
    };
in newPackage