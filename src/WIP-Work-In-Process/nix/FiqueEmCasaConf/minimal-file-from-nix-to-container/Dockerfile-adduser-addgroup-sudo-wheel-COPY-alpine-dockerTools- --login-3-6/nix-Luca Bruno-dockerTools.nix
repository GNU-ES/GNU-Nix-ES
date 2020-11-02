let
    pkgs = import <nixpkgs> {};


    entrypoint = pkgs.writeScript "entrypoint.sh" ''
        #!${pkgs.stdenv.shell}
        ${pkgs.dockerTools.shadowSetup}

        exec "$@"
    '';

in

pkgs.dockerTools.buildImage {
    name = "alpine-gnu-nix-es";
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
#        mkdir --mode=  755 --parents /nix/store/.links
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

        Env = [
            "NIX_PAGER=cat"
            # A user is required by nix
            # https://github.com/NixOS/nix/blob/9348f9291e5d9e4ba3c4347ea1b235640f54fd79/src/libutil/util.cc#L478
            "USER=pedroregispoar"
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