#!/bin/sh


echo

./script.sh \
    -a='-a' \
    -abcdfg='-abcdfg' \
    -abcdfg-123-42='-abcdfg-123-42' \
    --bc='--bc' \
    --bcd='--bcd' \
    --bcdefg='--bcdefg' \
    --bcdefg-123-42='--bcdefg-123-42'

echo

echo 'Note that it is not being used the = '
./script.sh \
    -a '-a' \
    -abcdfg '-abcdfg' \
    -abcdfg-123-42 '-abcdfg-123-42' \
    --bc '--bc' \
    --bcd '--bcd' \
    --bcdefg '--bcdefg' \
    --bcdefg-123-42 '--bcdefg-123-42'

echo
