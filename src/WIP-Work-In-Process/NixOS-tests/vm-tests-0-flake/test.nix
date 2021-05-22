{ pkgs, ... }: {
  nodes = { master = { pkgs, ... }: { }; };

  testScript = ''
    start_all()
    master.succeed("ls -al")
  '';
}
