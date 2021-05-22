

[Jérôme Petazzoni - Creating Optimized Images for Docker and Kubernetes](https://www.youtube.com/watch?v=UbXv-T4IUXk&list=PLf-O3X2-mxDmn0ikyO7OF8sPr2GDQeZXk&index=15)

`./run.sh`


TODO: using `flake` in the terminal run:

```
$ nix develop --help
...
To store the build environment in a profile:
$ nix develop --profile /tmp/my-shell nixpkgs#hello
...
```

It looks like it is possible to the same "trick" [Jérôme Petazzoni](put some usefull url here, his github?), 
i mean, install some thing to a profile using [`flake`](add link here) and use the `COPY` thing from 
"Docker mult stage build".