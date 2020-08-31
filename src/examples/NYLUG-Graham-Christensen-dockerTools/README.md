

```
nix-build ./uname-container.nix \
&& docker load < ./result \
&& docker run uname-test:0.0.1
```

`docker images | rg uname`




[How to build a docker container with nix?](https://stackoverflow.com/questions/43375880/how-to-build-a-docker-container-with-nix)


[Step 2: Using dockerTools](https://mpickering.github.io/posts/2018-09-19-nix-artefacts.html) Matthew Pickering



$ docker load --input $(nix-build layered.nix)
http://sandervanderburg.blogspot.com/2020/07/on-using-nix-and-docker-as-deployment.html

"The reason it works is that Nix can copy the minimal closure of a derivation out of the Nix store." February 1, 2016. 
[https://rodney.id.au/posts/2016-02-01-nix-dockertools/](https://rodney.id.au/posts/2016-02-01-nix-dockertools/)


[Chapter 19. Fundamentals of Stdenv](https://nixos.org/nixos/nix-pills/fundamentals-of-stdenv.html)

[From Zero to Application Delivery with NixOS](https://www.slideshare.net/mbbx6spp/from-zero-to-application-delivery-with-nixos)


[nix upgrade hell 003](https://www.youtube.com/watch?v=G0k5bu-xbUM)


[Jappie Klooster](https://www.youtube.com/channel/UCQxmXSQEYyCeBC6urMWRPVw/playlists)


[dockerTools.buildImage and user-writable /tmp](https://discourse.nixos.org/t/dockertools-buildimage-and-user-writable-tmp/5397/8)