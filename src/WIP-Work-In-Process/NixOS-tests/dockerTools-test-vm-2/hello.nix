{ pkgs }:

rec {

    myHello = pkgs.dockerTools.buildImage {
      name = "hello-docker-tools";
      tag = "0.0.1";
      config = { Cmd = [ "${pkgs.hello}/bin/hello" ]; };
    };
}