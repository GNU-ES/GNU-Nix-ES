let
   pkgs = import <nixpkgs> {};
in pkgs.dockerTools.buildImageWithNixDb {
    name = "nix";
    tag = "0.0.1";
    created = "now";

    contents = with pkgs; [
      # nix-store uses cat program to display results as specified by
      # the image env variable NIX_PAGER.
      coreutils
      file
      findutils
      gnutar
      #nix
      which
      ripgrep
      xz
      openssl
      ping
      bashInteractive
      wget
    ];

    runAsRoot = ''
    #!${pkgs.stdenv.shell}
    ${pkgs.dockerTools.shadowSetup}
    echo hosts: dns files > /etc/nsswitch.conf
    #mkdir /download-nix

    NIX_VERSION=2.3.6
    "${pkgs.wget}/bin/wget" --directory-prefix=/download-nix --no-check-certificate https://nixos.org/releases/nix/nix-$NIX_VERSION/nix-$NIX_VERSION-x86_64-linux.tar.xz
#    tar xf /download-nix/nix-$NIX_VERSION-x86_64-linux.tar.xz --directory=/download-nix/

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

    #echo 'sandbox = false' > /etc/nix/nix.conf
    mkdir --mode=1777 /tmp
    #mkdir -m 0755 /nix
    #USER=root sh /download-nix/nix-$NIX_VERSION-x86_64-linux/install
    '';

    #extraCommands = ''
    #USER=root sh /download-nix/nix-$NIX_VERSION-x86_64-linux/install
    #'';

    config = {
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
        "NIX_VERSION=2.3.7"
      ];
    };
}
