

Ideia: use `ONBUILD RUn` for entrypoint.


[Install Nix in multi-user mode on non-NixOS](https://nixos.wiki/wiki/Install_Nix_in_multi-user_mode_on_non-NixOS)


[This is how I currently got Nix installed on OSX:](https://github.com/NixOS/nix/issues/697)



[Docker image nixos/nix](https://hub.docker.com/r/nixos/nix/dockerfile)

the workaround I have seen is to (simplified):

    create a temporary user with sudo access
    install nix under that user
    delete the user
    configure the root account with the nix profile
[source](https://www.gitmemory.com/issue/NixOS/nix/1559/531690854)



[Think of the ONBUILD command as an instruction the parent Dockerfile gives to the child Dockerfile.](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#onbuild)

