#!/usr/bin/env bash

cd $HOME \
&& poetry new foo \
&& cd foo \
&& poetry config virtualenvs.create false --local \
&& python -m ensurepip --default-pip \
&& python -m ensurepip --version \
&& poetry add flask \
&& python -c 'import flask'
