

nix --version


nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix build nixpkgs#hello'
result/bin/hello

nix-collect-garbage --delete-old

nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix build nixpkgs#gcc'
result/bin/gcc --version


nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix develop github:ES-Nix/nix-flakes-shellHook-writeShellScriptBin-defaultPackage/9260e7ed15c91cc35c02bbdec1b1bff0c0931ec5 --command podman --version'

mkdir /etc/containers
cat << EOF > /etc/containers/policy.json
{
    "default": [
        {
            "type": "insecureAcceptAnything"
        }
    ],
    "transports":
        {
            "docker-daemon":
                {
                    "": [{"type":"insecureAcceptAnything"}]
                }
        }
}
EOF

nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes --run 'nix develop github:ES-Nix/nix-flakes-shellHook-writeShellScriptBin-defaultPackage/9260e7ed15c91cc35c02bbdec1b1bff0c0931ec5 --command podman pull alpine:3.13.0'
