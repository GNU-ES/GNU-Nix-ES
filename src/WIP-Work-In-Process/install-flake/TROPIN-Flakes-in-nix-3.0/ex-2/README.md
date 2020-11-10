

git init

git add .

git commit -m 'Some usefull information!'

git rev-parse $(git rev-parse --short HEAD)


I tryied this:

```
git clone https://github.com/nixos/nixpkgs.git \
&& cd nixpkgs \
&& git rev-parse $(git rev-parse --short HEAD) \
&& cd .. \
&& sudo rm --recursive nixpkgs
```