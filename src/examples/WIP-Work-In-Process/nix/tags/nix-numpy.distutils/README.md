

[https://numpy.org/devdocs/f2py/distutils.html](https://numpy.org/devdocs/f2py/distutils.html)


`docker build --tag pedroregispoar/f2py-primes.f95 .`

`docker build --tag pedroregispoar/f2py-primes.f95 . --no-cache`

```
docker run \
--interactive \
--rm \
--tty \
--volume "$(pwd)":/code \
--workdir /code \
pedroregispoar/f2py-primes.f95 \
bash
```


`python -c "import numpy as np; assert np.__version__ == '1.19.0'"`


`gfortran_version=$( echo "__GNUC__.__GNUC_MINOR__.__GNUC_PATCHLEVEL__" | gfortran -E -P - | sed 's/ //g')`
[Source](https://stackoverflow.com/questions/42176006/how-to-find-gfortran-version-number-in-a-portable-way-with-autoconf#comment71542834_42178860)


apt-cache show gfortran
