#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -eux pipefail

sudo setcap cap_setuid+ep $(readlink --canonicalize $(which newuidmap))
sudo setcap cap_setgid+ep $(readlink --canonicalize $(which newgidmap))

chmod -s $(readlink --canonicalize $(which newuidmap))
chmod -s $(readlink --canonicalize $(which newgidmap))

#mkdir --mode=755 --parent ~/.config/containers
# TODO: make test showing it is idempotent and respet if the
# folder has some thing in it.
mkdir --mode=755 --parent ~/.config/containers --verbose

cat << EOF > ~/.config/containers/policy.json
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