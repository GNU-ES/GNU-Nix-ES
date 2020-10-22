let
    pkgs = import <nixpkgs> {};


    entrypoint = pkgs.writeScript "entrypoint.sh" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.dockerTools.shadowSetup}

    set -e

    # allow the container to be started with `--user`
    if [ "$(${pkgs.coreutils}/bin/id -u)" = "0" ]; then
        #${pkgs.coreutils}/bin/chown -R redis .

        # What are the differences in doing it here or in the runAsRoot?
        #groupadd --gid 5000 app_group
        #useradd --no-log-init --uid 5000 --gid app_group pedroregispoar

        opt_u='pedroregispoar'
        opt_g='app_group'
        VOLUME_AND_WORKDIR='/code'

        OLD_UID=$( ${pkgs.getent}/bin/getent passwd "$opt_u" | cut --field=3 --delimiter=:)
        NEW_UID=$(stat --format="%u" $VOLUME_AND_WORKDIR)

        if [ "$OLD_UID" != "$NEW_UID" ]; then
            echo "Changing UID of $opt_u from $OLD_UID to $NEW_UID"
            usermod --uid "$NEW_UID" --non-unique "$opt_u"
            if [ -n "$opt_r" ]; then
                ${pkgs.coreutils}/bin/find / -xdev -user "$OLD_UID" -exec chown --no-dereference "$opt_u" {} \;
            fi
        fi

        OLD_GID=$(${pkgs.getent}/bin/getent group "$opt_g" | cut --field=3 --delimiter=:)
        NEW_GID=$(stat --format="%g" $VOLUME_AND_WORKDIR)

        if [ "$OLD_GID" != "$NEW_GID" ]; then
            echo "Changing GID of $opt_g from $OLD_GID to $NEW_GID"
            groupmod --gid "$NEW_GID" --non-unique "$opt_g"
            if [ -n "$opt_r" ]; then
                find / -xdev -group "$OLD_GID" -exec chgrp --no-dereference "$opt_g" {} \;
            fi
        fi
        #exec ${pkgs.gosu.bin}/bin/gosu app_user "$BASH_SOURCE" "$@"


        exec "$@"
    fi
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

    name = "gnu-nix-es";
    tag = "0.0.1";
    created = "now";

    runAsRoot = ''
        #!${pkgs.stdenv}
        export PATH=/bin:/usr/bin:/sbin:/usr/sbin:$PATH
        ${pkgs.dockerTools.shadowSetup}
        groupadd --gid 5000 app_group
        useradd --no-log-init --uid 5000 --gid app_group pedroregispoar


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