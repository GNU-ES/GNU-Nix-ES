#!/usr/bin/env bash

RAW_TEXT='WORD1 WORD2 WORD3 BLA BLA WORD1 WORD4 WORD3'

echo "$RAW_TEXT"

echo "$RAW_TEXT" | sed 's/WORD3/\n&/g;s/\(WORD1\)[^\n]*\n/\1 foo /g'
