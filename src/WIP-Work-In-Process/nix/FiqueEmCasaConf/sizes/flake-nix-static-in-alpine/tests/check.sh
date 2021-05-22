
#apk add --no-cache find
#find / -name result -exec rm -v {} \;

nix-collect-garbage --delete-old

SIZE_NIX=$(du -s /nix/ | cut -f1)

MAXIMUM_NIX_FOLDER_SIZE=80000

if [ "$SIZE_NIX" -gt "$MAXIMUM_NIX_FOLDER_SIZE" ]; then
  echo 'Error:'
  du -s /nix/
  exit 1
fi


LINES_IN_NIX_STORE=$(ls -al /nix/store/ | wc -l)

if [ "$LINES_IN_NIX_STORE" -gt '7' ]; then
  echo 'Error:'
  ls -al /nix/store/
  exit 1
fi

stat -c %F /nix/store/.links | grep 'directory'

