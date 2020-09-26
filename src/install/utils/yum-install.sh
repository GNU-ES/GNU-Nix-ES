#!/bin/sh

set -ex


yum -y update

yum -y install "$@"

yum clean all

exit 0
