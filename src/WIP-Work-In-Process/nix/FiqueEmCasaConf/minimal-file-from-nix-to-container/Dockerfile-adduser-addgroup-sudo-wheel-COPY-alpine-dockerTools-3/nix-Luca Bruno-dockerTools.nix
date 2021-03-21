let
    pkgs = import <nixpkgs> {};


    entrypoint = pkgs.writeScript "entrypoint.sh" ''
        #!${pkgs.stdenv.shell}
        ${pkgs.dockerTools.shadowSetup}

        exec "$@"
    '';

  ubuntuBase = pkgs.dockerTools.pullImage {
    imageName = "nixos/nix";
    imageDigest = "sha256:15299d86263a3059cf19f419f9d286cc9f06d3c13146a8ebbb21b3437f598357";
    #imageDigest = "sha256:0179d85479fde68004bed845d43e79c85ab22b4e862ba46d9aeaad5e707b0e3";
    #imageDigest = "sha256:85299d86263a3059cf19f419f9d286cc9f06d3c13146a8ebbb21b3437f598357";
    sha256 = "07q9y9r7fsd18sy95ybrvclpkhlal12d30ybnf089hq7v1hgxbi7";
    #sha256 = "0vnp3mhpk4ny3xa3cgngqsargnmvfgld54d5sn4b5av6yqzzp67z";
    finalImageTag = "2.2.1";
    finalImageName = "nix";
  };

in

pkgs.dockerTools.buildImage {
    fromImage = ubuntuBase;

    name = "alpine-gnu-nix-es";
    #tag = "3.12.0";
    #created = "now";

    runAsRoot = ''
        #!${pkgs.stdenv}
        export PATH=/bin:/usr/bin:/sbin:/usr/sbin:$PATH
        ${pkgs.dockerTools.shadowSetup}
        #groupadd --gid 5000 wheel
 #       useradd --no-log-init -s /bin/sh /home/pedroregispoar --password=123 --system --uid 5000 --gid wheel pedroregispoar

        echo '#Admins' >> /etc/sudoers
        echo 'pedroregispoar    ALL=(ALL) ALL' >> /etc/sudoers

#        # Here the sudoers file is edited
#        # https://stackoverflow.com/a/27355109
#        ${pkgs.gnused}/bin/sed -i '/wheel/s/^#//g' /etc/sudoers

#        chown root:root /bin/sudo
#        chmod 777 /bin/sudo
#        chmod g+s /bin/sudo

    '';

    #extraCommands = ''
    #USER=root sh /download-nix/nix-$NIX_VERSION-x86_64-linux/install
    #'';

    contents = with pkgs; [
        bashInteractive
        coreutils
        which
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