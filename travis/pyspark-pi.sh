#!/usr/bin/env bash

export HADOOP_HOME=~/opt/hadoop-2.7.7
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export SPARK_HOME=~/opt/spark-3.0.0-bin-hadoop2.7

export PATH=$HADOOP_HOME/bin:$SPARK_HOME/bin:$PATH

export PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH
export PYSPARK_PYTHON=python3

sudo apt-get update
sudo apt purge python2.7-minimal
sudo apt-get install python3 python3-pip python3-setuptools

pip3 install --upgrade pip
pip3 install numpy

cd $SPARK_HOME

which python3
which python
python --version

/bin/spark-submit examples/src/main/python/pi.py
