

[nixos-shell](https://github.com/Mic92/nixos-shell)

To install the `nixos-shell` (at least in `NixOS`, 
TODO: check how to install it in non `NixOS`):

`nix-env --install --attr nixos.nixos-shell`

```
git clone https://github.com/Mic92/nixos-shell.git \
&& cd nixos-shell/examples \
&& nixos-shell
```

```
Log in as "root" with an empty password.
If you are connect via serial console:
Type Ctrl-a c to switch to the qemu console
and `quit` to stop the VM.
```

If you are confused with what exactly `Ctrl-a c` mean, it means press `Ctrl` and while `Ctrl` 
still pressed press/hit `a`, unpress `Ctrl` and press `c` and after beeing teleported to the QEMU
conseole type `quit`.
