#!/usr/bin/env bash

export HADOOP_HOME=~/opt/hadoop-2.7.7
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export SPARK_HOME=~/opt/spark-3.0.0-bin-hadoop2.7

export PATH=$HADOOP_HOME/bin:$SPARK_HOME/bin:$PATH

export PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH
export PYSPARK_PYTHON=python3

hadoop fs -mkdir -p data/mllib
hadoop fs -copyFromLocal $SPARK_HOME/data/mllib/sample_kmeans_data.txt data/mllib

cd $SPARK_HOME

./bin/spark-submit examples/src/main/python/ml/kmeans_example.py
