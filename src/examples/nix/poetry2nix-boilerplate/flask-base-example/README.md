

[Jérôme Petazzoni - Creating Optimized Images for Docker and Kubernetes](https://www.youtube.com/watch?v=UbXv-T4IUXk&list=PLf-O3X2-mxDmn0ikyO7OF8sPr2GDQeZXk&index=15)

`docker build --tag pedroregispoar/flasknix .`

docker build --target builder --tag pedroregispoar/builder/flasknix .

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/flasknix
```

docker run pedroregispoar/flasknix nixfriday



docker run \
--interactive \
--rm \
--tty \
pedroregispoar/builder/flasknix






docker run \
--interactive \
--rm \
--tty \
4a487cbbcb42


ls -ls /dev/console