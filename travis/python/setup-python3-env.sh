#!/usr/bin/env bash

apt-get update
apt-get install python3-pip

pip3 install --upgrade pip
pip3 install numpy

echo python is $(which python) $(python --version)
echo python3 is $(which python3) $(python3 --version)
