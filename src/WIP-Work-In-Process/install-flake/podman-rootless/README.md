

```
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout initial-stuff \
&& cd src/WIP-Work-In-Process/install-flake/podman-rootless \
&& ./run
```

```
rm --force --verbose disk.qcow2 userdata.qcow2 \
&& ./run.sh
```