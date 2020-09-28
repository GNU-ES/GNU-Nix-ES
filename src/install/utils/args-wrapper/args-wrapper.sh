## TODO: better documentation on what it does, where it is documented officially
#DIR="${BASH_SOURCE%/*}"
#
#
## TODO: Advantages and Limitations
## echo "$(pwd)"
## vs
## echo "$PWD"
#if [ ! -d "$DIR" ]; then
#    DIR="$PWD"
#    echo 'DEBUG: ''$DIR='"$DIR"
#fi


. ./utils/args-wrapper/flags-declares.sh

. ./utils/args-wrapper/variables.sh

. ./utils/args-wrapper/flags-arguments.sh
