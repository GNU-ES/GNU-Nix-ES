

curl -O -L https://raw.githubusercontent.com/target/lorri/master/contrib/lorri.socket

curl -O -L https://raw.githubusercontent.com/target/lorri/master/contrib/lorri.service


mkdir --parent ~/.config/systemd/user && \
    cp lorri.{socket,service} ~/.config/systemd/user/ && \
    systemctl --user daemon-reload && \
    systemctl --user enable --now lorri.socket

systemctl --user is-enabled lorri.socket

systemctl --user is-active lorri.socket

TODO: como pinnar uma versão??
nix-channel --list

nix-env --install direnv


echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc




