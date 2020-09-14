


Tem que fazer uma derivação que compila o python "dessa forma". Se a imagem oficial alpine tem 42.7MB. 
Para checar:
`docker pull python:3.8.5-alpine3.12 && docker images | grep 872c3118ec53`

Então deve ser possivel fazer no `Nix`.


https://github.com/docker-library/python/blob/4be4d491780c476d79e42f1d8750244665db450e/3.8/alpine3.12/Dockerfile
