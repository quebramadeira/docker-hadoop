#!/bin/bash

su - hdfs -c "$HADOOP_HOME/bin/hdfs namenode -format cluster1" && su - hdfs -c "$HADOOP_HOME/bin/hdfs --daemon start namenode"
su - yarn -c "$HADOOP_HOME/bin/yarn --daemon start resourcemanager"
while true; do sleep 1; done
