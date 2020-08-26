#!/usr/bin/env bash

export HADOOP_HOME=~/opt/hadoop-2.7.7
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export SPARK_HOME=~/opt/spark-3.0.0-bin-hadoop2.7

export PATH=$HADOOP_HOME/bin:$SPARK_HOME/bin:$PATH

cd $SPARK_HOME

source "$HOME/miniconda/etc/profile.d/conda.sh"
conda activate test-environment

which python

# ./bin/spark-submit examples/src/main/python/pi.py

hadoop fs -mkdir -p data/mllib
hadoop fs -copyFromLocal $SPARK_HOME/data/mllib/sample_kmeans_data.txt data/mllib

./bin/spark-submit examples/src/main/python/ml/kmeans_example.py
