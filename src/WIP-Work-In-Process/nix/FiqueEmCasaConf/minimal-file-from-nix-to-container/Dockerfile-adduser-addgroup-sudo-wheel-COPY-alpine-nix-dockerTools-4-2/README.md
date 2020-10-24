

git config --global user.email "you@example.com" \
&& git config --global user.name "Your Name" \
&& cd /etc2/ \
&& git init \
&& git add --all \
&& git commit --message 'To see diff' \
&& cp -f /etc/* /etc2/ \
&& ls -al


https://stackoverflow.com/a/55626495

docker inspect --format='{{index .Id}}' $IMAGE


https://maori.geek.nz/how-to-digest-a-docker-image-ca9fc7630b71

