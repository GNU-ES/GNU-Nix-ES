{ pkgs, ... }: {

  machine = { pkgs, ... }: { environment.systemPackages = [ pkgs.coreutils ]; };

}
