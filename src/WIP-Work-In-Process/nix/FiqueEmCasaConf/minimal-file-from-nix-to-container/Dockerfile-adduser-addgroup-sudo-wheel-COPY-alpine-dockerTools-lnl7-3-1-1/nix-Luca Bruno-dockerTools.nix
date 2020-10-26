let
    pkgs = import <nixpkgs> {};

    nonRootShadowSetup = { user, uid, gid ? uid }: with pkgs; [
          (
          writeTextDir "etc/shadow" ''
            root:!x:::::::
            ${user}:!:::::::
          ''
          )
          (
          writeTextDir "etc/passwd" ''
            root:x:0:0::/root:${runtimeShell}
            ${user}:x:${toString uid}:${toString gid}::/home/${user}:
          ''
          )
          (
          writeTextDir "etc/group" ''
            root:x:0:
            ${user}:x:${toString gid}:
          ''
          )
          (
          writeTextDir "etc/gshadow" ''
            root:x::
            ${user}:x::
            sudo:x::
          ''
          )
    ];
    entrypoint = pkgs.writeScript "entrypoint.sh" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.dockerTools.shadowSetup}

    set -e

    # allow the container to be started with `--user`
    if [ "$(${pkgs.coreutils}/bin/id -u)" = "0" ]; then
        opt_u='pedroregispoar'
        opt_g='pedroregispoar'
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
        exec ${pkgs.gosu.bin}/bin/gosu "$opt_u" "$BASH_SOURCE" "$@"
    fi
    exec "$@"
    '';

  ubuntuBase = pkgs.dockerTools.pullImage {
   imageName = "lnl7/nix";
   finalImageTag = "2.0";
   imageDigest = "sha256:632268d5fd9ca87169c65353db99be8b4e2eb41833b626e09688f484222e860f";
   sha256 = "1x00ks05cz89k3wc460i03iyyjr7wlr28krk7znavfy2qx5a0hfd";
  };

in

pkgs.dockerTools.buildImage {
    fromImage = ubuntuBase;

    name = "alpine-gnu-nix-es";
    tag = "3.12.0";
    created = "now";

    runAsRoot = ''
#        #!${pkgs.stdenv}
#        ${pkgs.dockerTools.shadowSetup}
#        groupadd --gid 5000 pedroregispoar_group
#        useradd --no-log-init -s /bin/sh --home-dir /home/pedroregispoar --system --uid 5000 --gid pedroregispoar_group pedroregispoar

#        echo 'root ALL=(ALL) ALL' >> /etc/sudoers
#        echo ' %wheel ALL=(ALL) ALL' >> /etc/sudoers
#        echo ' %wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

        #mkdir -m 0755 /nix
        #chown --recursive pedroregispoar /nix
        #chown -R pedroregispoar /nix

#        echo '#Admins' >> /etc/sudoers
#        echo 'pedroregispoar    ALL=(ALL) ALL' >> /etc/sudoers

        # Here the sudoers file is edited
        # https://stackoverflow.com/a/27355109
#        ${pkgs.gnused}/bin/sed -i '/wheel/s/^#//g' /etc/sudoers

    '';

    #extraCommands = ''
    #USER=root sh /download-nix/nix-$NIX_VERSION-x86_64-linux/install
    #'';

    contents = with pkgs; [
        bashInteractive
        coreutils
        gcc
        which
        man
        neovim
        nix
    ] ++ nonRootShadowSetup { uid = 999; user = "pedroregispoar"; };

    config = {

        #Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];

        Entrypoint = [ entrypoint ];

        Env = [
            #"NIX_PAGER=cat"
            # A user is required by nix
            # https://github.com/NixOS/nix/blob/9348f9291e5d9e4ba3c4347ea1b235640f54fd79/src/libutil/util.cc#L478
            "USER=pedroregispoar"
            "ENV=/etc/profile"
            "HOME=/home/pedroregispoar"
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