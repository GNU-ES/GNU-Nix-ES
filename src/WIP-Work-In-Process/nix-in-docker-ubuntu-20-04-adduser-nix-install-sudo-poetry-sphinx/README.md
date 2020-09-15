# First

```
#!/usr/bin/env bash
git clone https://github.com/GNU-ES/GNU-Nix-ES.git \
&& cd GNU-Nix-ES \
&& git checkout a674302cf85f80ff9b7368c25ccd8f61d8205cca \
&& cd src/broken/to-test-ci \
&& cd nix-in-docker-ubuntu-20-04-adduser-nix-install-sudo-flake-python3 \
&& ./run.sh
```

If you already have cloned, run the script:
`./run.sh`


## Play around

If it works play in the interactive mode


&& poetry new foo \
&& cd foo \
&& poetry config virtualenvs.create false --local \
&& poetry add flask \
&& python -c 'import flask'
