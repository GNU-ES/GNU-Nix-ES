

nix-shell -p 'musl' --run 'echo "int main(void) { return 0; }" | musl-gcc -static -xc - && ./a.out'
nix-shell -p 'musl' --run 'echo "int main(void) { return 0; }" | musl-gcc -xc - && ./a.out'
https://github.com/NixOS/nixpkgs/issues/94228

https://github.com/NixOS/nixpkgs/issues/97351#issuecomment-688647104