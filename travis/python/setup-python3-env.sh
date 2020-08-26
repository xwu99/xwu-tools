#!/usr/bin/env bash

apt-get update
# apt purge python2.7-minimal
# apt-get install python3 python3-pip python3-setuptools

pip3 install --upgrade pip
pip3 install numpy

which python
python --version

which python3
python3 --version
