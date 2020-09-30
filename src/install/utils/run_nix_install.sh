
INPUTED_USER_OR_DEFAULT=${1:-GNU-Nix-ES}
INPUTED_PASSWORD_OR_DEFAULT=${2:-'123'}

#echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S curl -L https://nixos.org/nix/install | sh


curl -L https://nixos.org/nix/install -o "$(pwd)"/nix_oficial_installer.sh

#su "$INPUTED_USER_OR_DEFAULT" -c "echo "$INPUTED_PASSWORD_OR_DEFAULT" | sudo -S ./utils/nix_oficial_installer.sh"

#su "$INPUTED_USER_OR_DEFAULT" -c 'sudo -S ./utils/nix_oficial_installer.sh'

#echo '. /home/'"$INPUTED_USER_OR_DEFAULT"'/.nix-profile/etc/profile.d/nix.sh' >> /home/"$INPUTED_USER_OR_DEFAULT"/.bashrc
