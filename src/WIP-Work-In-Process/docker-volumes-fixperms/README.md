#


"The intent is to prepend that script as the first argument to 
ENTRYPOINT which should cause Docker to infer UID and GID from a relevant bind mount."

[source](https://stackoverflow.com/questions/49955097/how-do-i-add-a-user-when-im-using-alpine-as-a-base-image)


TODO: look: `exec su-exec <my-user> <my command>`
https://stackoverflow.com/questions/49225976/use-sudo-inside-dockerfile-alpine

https://docs.alpinelinux.org/user-handbook/0.1a/Working/post-install.html

Many (bad) workarounds:
https://github.com/mhart/alpine-node/issues/48


