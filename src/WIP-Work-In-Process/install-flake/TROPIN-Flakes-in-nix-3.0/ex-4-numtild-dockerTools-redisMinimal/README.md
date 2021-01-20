


docker run --interactive --net=host --tty --rm --workdir /code --volume "$(pwd)":/code ubuntu:20.04 bash

apt-get update

apt-get install -y redis-server

redis-server --version

ldd $(which redis-server)

TODO: combine ldd $(which id) with a `find` to do a the recursion part.
User this to build a image of the closure of the minimal iso with red nodes
of packages that still not pure. 

TODO: create a pacth and version it, but aply it inside the repository 
created in this folder to show that it 