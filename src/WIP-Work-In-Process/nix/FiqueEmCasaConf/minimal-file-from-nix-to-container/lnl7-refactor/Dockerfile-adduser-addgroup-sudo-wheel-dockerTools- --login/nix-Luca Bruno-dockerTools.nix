{ src ? ./srcs/2020-09-11.nix, nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

let
    #pkgs = import <nixpkgs> {};

    inherit (pkgs) dockerTools stdenv buildEnv writeText;
    inherit (pkgs) bashInteractive coreutils cacert nix openssh;

    inherit (native.lib) concatStringsSep genList;

    pkgs = import unstable { system = "x86_64-linux"; };

    entrypoint = pkgs.writeScript "entrypoint.sh" ''
        #!${pkgs.stdenv.shell}
        ${pkgs.dockerTools.shadowSetup}

        exec "$@"
    '';


  native = import nixpkgs { inherit system; };
  #unstable = native.callPackage src { stdenv = native.stdenvNoCC; };

  shadow = pkgs.shadow.override { pam = null; };

  path = buildEnv {
    name = "system-path";
    paths = [ bashInteractive coreutils nix shadow ];
  };

  nixconf = ''
    build-users-group = nixbld
    sandbox = false
  '';

  passwd = ''
    root:x:0:0::/root:/run/current-system/sw/bin/bash
    pedroregispoar:x:12345:67890::/home/pedroregispoar:
    ${concatStringsSep "\n" (genList (i: "nixbld${toString (i+1)}:x:${toString (i+30001)}:30000::/var/empty:/run/current-system/sw/bin/nologin") 32)}
  '';

  group = ''
    root:x:0:
    pedroregispoar:x:67890:
    nixbld:x:30000:${concatStringsSep "," (genList (i: "nixbld${toString (i+1)}") 32)}
  '';

  nsswitch = ''
    hosts: files dns myhostname mymachines
  '';

  contents = stdenv.mkDerivation {
    name = "user-environment";
    phases = [ "installPhase" "fixupPhase" ];

    exportReferencesGraph =
      map (drv: [("closure-" + baseNameOf drv) drv]) [ path cacert ];

    installPhase = ''
      mkdir -p $out/run/current-system $out/var
      ln -s /run $out/var/run
      ln -s ${path} $out/run/current-system/sw

      mkdir -p $out/bin $out/usr/bin $out/sbin
      ln -s ${stdenv.shell} $out/bin/sh
      ln -s ${coreutils}/bin/env $out/usr/bin/env

      mkdir -p $out/etc/nix
      echo '${nixconf}' > $out/etc/nix/nix.conf
      echo '${passwd}' > $out/etc/passwd
      echo '${group}' > $out/etc/group
      echo '${nsswitch}' > $out/etc/nsswitch.conf

      printRegistration=1 ${pkgs.perl}/bin/perl ${pkgs.pathsFromGraph} closure-* > $out/.reginfo
    '';
  };

in

pkgs.dockerTools.buildImage {
    name = "gnu-nix-es";
    tag = "0.0.1";
    created = "now";

    runAsRoot = ''
        #!${pkgs.stdenv}

        ${pkgs.dockerTools.shadowSetup}

        groupadd --gid 10 wheel

        useradd --no-log-init -s "${pkgs.bashInteractive}/bin/bash" --home-dir /home/pedroregispoar --system --uid 5000 --gid wheel pedroregispoar

        echo 'root ALL=(ALL) ALL' >> /etc/sudoers
        echo ' %wheel ALL=(ALL) ALL' >> /etc/sudoers
        echo ' %wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

        chmod 0755 /nix/
        chmod 4511 /sbin/sudo
        chmod 4511 /bin/sudo
#        mkdir --mode=755 --parents /nix/store/.links
#        mkdir --mode=755 --parents /nix/var/nix/profiles/per-user/pedroregispoar

        echo "Set disable_coredump false" >> etc/sudo.conf

        groupadd --system nixbld

        for n in $(seq 1 10); do
            useradd \
            --comment "Nix build user $n" \
            --gid nixbld \
            --groups nixbld \
            --home-dir /var/empty \
            --no-create-home \
            --no-user-group \
            --shell "$(which nologin)" \
            --system \
            nixbld$n; done

    '';

    #extraCommands = ''
    #    chown pedroregispoar ${pkgs.sudo}/bin/
    #'';

    contents = with pkgs; [
        bashInteractive
        coreutils
        which
        nix
        su
        sudo
       ];

    config = {

        #Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];

        Entrypoint = [ entrypoint ];

        #Env = [
        #    "NIX_PAGER=cat"
        #    # A user is required by nix
        #    # https://github.com/NixOS/nix/blob/9348f9291e5d9e4ba3c4347ea1b235640f54fd79/src/libutil/util.cc#L478
        #    "USER=pedroregispoar"
        #    "ENV=/etc/profile"
        #    "PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
        #    "NIX_PATH=/nix/var/nix/profiles/per-user/root/channels"
        #    "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bunle.crt"
        #    "GIT_SSL_CAINFO=${pkgs.cacert}/etc/ssl/certs/ca-bunle.crt"
        #    #"NIX_VERSION=2.3.7"
        #];

        inherit contents;

        Cmd = [ "${bashInteractive}/bin/bash" ];
        Env =
          [ "PATH=/root/.nix-profile/bin:/run/current-system/sw/bin"
            "MANPATH=/root/.nix-profile/share/man:/run/current-system/sw/share/man"
            "NIX_PAGER=cat"
            "NIX_PATH=nixpkgs=${unstable}"
            "NIX_SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt"
          ];

        WorkingDir = "/code";

        Volumes = {
          "/code" = {};
        };
    };
}