

[Jérôme Petazzoni - Creating Optimized Images for Docker and Kubernetes](https://www.youtube.com/watch?v=UbXv-T4IUXk&list=PLf-O3X2-mxDmn0ikyO7OF8sPr2GDQeZXk&index=15)

`docker build --tag pedroregispoar/inplant-python-in-ubuntu-20-04 .`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/inplant-python-in-ubuntu-20-04 \
bash
```


docker run pedroregispoar/redisnix redis-server
