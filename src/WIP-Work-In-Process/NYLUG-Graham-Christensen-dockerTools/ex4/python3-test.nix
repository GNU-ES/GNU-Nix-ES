let
   pkgs = import <nixpkgs> {};
in pkgs.dockerTools.buildLayeredImage {
  name = "python3-test";
  tag = "0.0.1";
  config.Env = [
    "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bunle.crt"
  ];
  config.Entrypoint = [ "${pkgs.python39}/bin/python" ];
}
