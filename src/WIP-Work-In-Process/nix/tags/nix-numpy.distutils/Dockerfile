FROM python:3.8.2-buster

RUN apt-get update && apt-get install -y gfortran=4:8.3.0-1
# RUN apt-get update && apt-get install -y gcc=4:8.3.0-1


RUN pip3 install --upgrade --no-cache-dir pip==20.1.1 \
&& pip3 install --no-cache-dir numpy

WORKDIR /code


COPY . /code

RUN python -m numpy.f2py -c primes.f95 -m primes && ls primes.cpython-38-x86_64-linux-gnu.so

RUN python test.py
