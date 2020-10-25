let
    pkgs = import <nixpkgs> {};


    entrypoint = pkgs.writeScript "entrypoint.sh" ''
        #!${pkgs.stdenv.shell}
        ${pkgs.dockerTools.shadowSetup}

        exec "$@"
    '';

  ubuntuBase = pkgs.dockerTools.pullImage {
    imageName = "alpine:3.12.0";
    imageDigest = "sha256:a24bb4013296f61e89ba57005a7b3e52274d8edd3ae2077d04395f806b63d83e";
    sha256 = "07q9y9r7fsd18sy95ybrvclpkhlal12d30ybnf089hq7v1hgxbi7";
    finalImageTag = "2.2.1";
    finalImageName = "nix";
  };

in

pkgs.dockerTools.buildImage {
    fromImage = ubuntuBase;

    name = "alpine-gnu-nix-es";
    tag = "3.12.0";
    created = "now";

    runAsRoot = ''
        #!${pkgs.stdenv}
        ${pkgs.dockerTools.shadowSetup}

        useradd --no-log-init -s /bin/sh --home-dir /home/pedroregispoar --system --uid 5000 --gid wheel pedroregispoar
    '';

    #extraCommands = ''
    #USER=root sh /download-nix/nix-$NIX_VERSION-x86_64-linux/install
    #'';

    contents = with pkgs; [
        bashInteractive
        coreutils
        which
        git
        nix
       ];

    config = {

        #Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];

        Entrypoint = [ entrypoint ];

        Env = [
            "NIX_PAGER=cat"
            # A user is required by nix
            # https://github.com/NixOS/nix/blob/9348f9291e5d9e4ba3c4347ea1b235640f54fd79/src/libutil/util.cc#L478
            "USER=root"
            "ENV=/etc/profile"
            "PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
            "NIX_PATH=/nix/var/nix/profiles/per-user/root/channels"
            "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bunle.crt"
            "GIT_SSL_CAINFO=${pkgs.cacert}/etc/ssl/certs/ca-bunle.crt"
            #"NIX_VERSION=2.3.7"
        ];

        WorkingDir = "/code";

        Volumes = {
          "/code" = {};
        };
    };
}