#!/usr/bin/env bash

cd $HOME \
&& poetry new foo \
&& cd foo \
&& python -m ensurepip --default-pip \
&& python -m ensurepip --version \
&& poetry add flask \
&& python -c 'import flask'

# Makes no difference:
#&& poetry config virtualenvs.create false --local \