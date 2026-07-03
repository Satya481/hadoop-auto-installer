#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"
source "$SCRIPT_DIR/lib/colors.sh"

banner

echo
echo "Running Hadoop Services"
echo "--------------------------------------"

jps

echo
echo "Web Interfaces"
echo "--------------------------------------"

echo "HDFS : http://localhost:9870"
echo "YARN : http://localhost:8088"
