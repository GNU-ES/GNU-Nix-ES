

nix-shell -p 'musl' --run 'echo "int main(void) { return 0; }" | musl-gcc -static -xc - && ./a.out'
nix-shell -p 'musl' --run 'echo "int main(void) { return 0; }" | musl-gcc -xc - && ./a.out'
https://github.com/NixOS/nixpkgs/issues/94228

https://github.com/NixOS/nixpkgs/issues/97351#issuecomment-688647104


Haskell buid with musl
https://input-output-hk.github.io/haskell.nix/tutorials/cross-compilation/#static-executables-with-musl-libc


Static linking with Musl in Nixpkgs
http://blog.inner-haven.net/static-linking-with-musl-in-nixpkgs/


How to build a simple static Rust binary using musl?
https://www.reddit.com/r/NixOS/comments/f0yi3b/how_to_build_a_simple_static_rust_binary_using/


TODO: join with what is is python3Minimal
du -sch (nix-store -qR (nix-build '<nixpkgs>' --no-out-link -A python3Minimal)) | sort -h

https://github.com/NixOS/nixpkgs/pull/66762#
https://github.com/NixOS/nixpkgs/pull/66762#issuecomment-522362845
https://discourse.nixos.org/t/cross-compiling-libx11-with-musl/4763/3


TODO: reproduce this!
nix-env --set-flag priority 4 python3-minimal-3.7.6
nix-env --install --attr nixos.python38Full