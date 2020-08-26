#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install python3-pip python3-setuptools python3-wheel

sudo -H pip3 install numpy

echo python is in $(which python) 
python --version

echo python3 is in $(which python3) 
python3 --version
