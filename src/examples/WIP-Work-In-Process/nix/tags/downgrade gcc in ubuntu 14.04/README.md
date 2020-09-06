

[https://www.quora.com/How-do-I-downgrade-gcc-in-ubuntu-14-04-4-8-4-to-4-7-*](https://www.quora.com/How-do-I-downgrade-gcc-in-ubuntu-14-04-4-8-4-to-4-7-*)


`docker build --tag pedroregispoar/ubuntu-14.04-gcc .`

`docker build --tag pedroregispoar/ubuntu-14.04-gcc . --no-cache`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/ubuntu-14.04-gcc \
bash
```


`python -c "import numpy as np; assert np.__version__ == '1.19.0'"`


`gfortran_version=$( echo "__GNUC__.__GNUC_MINOR__.__GNUC_PATCHLEVEL__" | gfortran -E -P - | sed 's/ //g')`
[Source](https://stackoverflow.com/questions/42176006/how-to-find-gfortran-version-number-in-a-portable-way-with-autoconf#comment71542834_42178860)


apt-cache show gfortran
