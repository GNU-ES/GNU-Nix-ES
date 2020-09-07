let
   pkgs = import <nixpkgs> {};
in pkgs.dockerTools.buildLayeredImage {
  name = "curl-test";
  tag = "0.0.1";
  config.Env = [
    "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bunle.crt"
  ];
  config.Entrypoint = [ "${pkgs.curl}/bin/curl" ];
}
