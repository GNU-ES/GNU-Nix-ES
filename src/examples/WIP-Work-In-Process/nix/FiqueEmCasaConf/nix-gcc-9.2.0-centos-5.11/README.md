

[Jérôme Petazzoni - Creating Optimized Images for Docker and Kubernetes](https://www.youtube.com/watch?v=UbXv-T4IUXk&list=PLf-O3X2-mxDmn0ikyO7OF8sPr2GDQeZXk&index=15)

`docker build --tag pedroregispoar/nix-gcc-9.2.0-centos-5.11 .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/nix-gcc-9.2.0-centos-5.11 \
bash
```

nix path-info --recursive --size --closure-size --human-readable nixpkgs.coreutils
