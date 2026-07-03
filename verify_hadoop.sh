#!/bin/bash

clear

echo "========================================="
echo "      Hadoop Verification"
echo "========================================="

echo
echo "Java Version"
java -version

echo
echo "Hadoop Version"
hadoop version

echo
echo "Running Hadoop Services"
jps

echo
echo "HDFS Web UI"
echo "http://localhost:9870"

echo
echo "YARN Web UI"
echo "http://localhost:8088"

echo
echo "Root HDFS Directory"
hdfs dfs -ls /

echo
echo "Verification Complete"
