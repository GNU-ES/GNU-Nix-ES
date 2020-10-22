

git config --global user.email "you@example.com" \
&& git config --global user.name "Your Name" \
&& cd /etc2/ \
&& git init \
&& git add --all \
&& git commit --message 'To see diff' \
&& cp -f /etc/* /etc2/ \
&& ls -al