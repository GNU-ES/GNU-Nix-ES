

Whe tried to run in OCI image using Docker:

sudo mkdir --mode=755 /home/pedroregispoar/.local
sudo chown pedroregispoar:pedroregispoargroup /home/pedroregispoar/.local


sudo mkdir --mode=755 --parent /run/systemd/journal/socket
sudo chown pedroregispoar:pedroregispoargroup /run/systemd/journal/socket


sudo su -c 'echo pedroregispoar:100000:65536 >> /etc/subuid'
sudo su -c 'sudo echo pedroregispoar:100000:65536 >> /etc/subgid'
