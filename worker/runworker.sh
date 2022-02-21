#!/bin/bash

su - hdfs -c "$HADOOP_HOME/bin/hdfs --daemon start datanode"
su - yarn -c "$HADOOP_HOME/bin/yarn --daemon start nodemanager"
while true; do sleep 1; done

