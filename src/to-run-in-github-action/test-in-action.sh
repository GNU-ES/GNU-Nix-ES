#!/usr/bin/env bash

RAW_TEXT='WORD1 WORD2 WORD3 BLA BLA WORD1 WORD4 WORD3'

echo "$RAW_TEXT"

echo "$RAW_TEXT" | sed 's/WORD3/\n&/g;s/\(WORD1\)[^\n]*\n/\1 foo /g'


RAW_TEXT='&& git checkout 2192bf9fd983b70a692be0541ddc3f583e327a72 \'

echo "$RAW_TEXT"

#echo "$RAW_TEXT" | sed -E 's/[a-f0-9]{40}/bar/g'
echo "$RAW_TEXT" | sed --regexp-extended 's/\b([a-f0-9]{40})\b/bar/g'

# -E
#https://unix.stackexchange.com/a/78626
#
# /\b([a-f0-9]{40})\b/
#https://stackoverflow.com/a/468397

# Extras
#https://stackoverflow.com/a/10616254