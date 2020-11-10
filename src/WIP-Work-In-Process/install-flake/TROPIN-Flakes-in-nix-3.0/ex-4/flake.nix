{
  description = "A usefull description";
  inputs = { unstable.url = github:NixOS/nixpkgs/nixos-unstable; };

  outputs = inputs: {
    defaultPackage.x86_64-linux = import ./test.nix { npkgs = inputs.unstable; };
  };

}
