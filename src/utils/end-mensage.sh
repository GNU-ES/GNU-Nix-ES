#!/usr/bin/env bash

# Source:
# https://stackoverflow.com/a/28938235
BLUE='\033[0;34m'
BBlue='\033[1;34m'
IBlue='\033[0;94m'
BIBlue='\033[1;94m'
GREEN='\033[0;32m'
BGreen='\033[1;32m'
ICyan='\033[0;96m'
IGreen='\033[0;92m'
IRed='\033[0;91m'
IPurple='\033[0;95m'
RED='\033[0;31m'

NC='\033[0m'
On_White='\033[47m'


echo -e "${BGreen}This example worked!!Obviously, it is${NC} ${BIBlue}Nix${NC} ${BGreen}dah!!${NC}"
echo -e "                   ${IPurple}The end${NC}${IRed}!!${NC}"
echo -e "       ${On_White}${GREEN}GNU-Nix-ES${NC} ${BIBlue}let change the world!!${NC}"

# I divided the spaces:
#python -c 'print(len("This example worked!!Obviously, it is Nix dah!!"))'
#47
#python -c 'print(len("The end!!"))'
#9
#python -c 'print(len("GNU-Nix-ES let change the world!!"))'
#33


