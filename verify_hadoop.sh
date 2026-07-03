#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

source "$SCRIPT_DIR/lib/colors.sh" 2>/dev/null
source "$SCRIPT_DIR/lib/logger.sh" 2>/dev/null

clear

echo "=================================================="
echo "        Hadoop Installation Verification"
echo "=================================================="
echo

pass() {
    echo "[PASS] $1"
}

fail() {
    echo "[FAIL] $1"
}

echo "Checking Java..."

if command -v java >/dev/null 2>&1; then
    pass "Java Installed"
    java -version 2>&1 | head -n 1
else
    fail "Java Not Installed"
fi

echo

echo "Checking JAVA_HOME..."

if [ -n "$JAVA_HOME" ]; then
    pass "JAVA_HOME Configured"
    echo "$JAVA_HOME"
else
    fail "JAVA_HOME Not Configured"
fi

echo

echo "Checking Hadoop..."

if command -v hadoop >/dev/null 2>&1; then
    pass "Hadoop Installed"
    hadoop version | head -n 1
else
    fail "Hadoop Not Installed"
fi

echo

echo "Checking HADOOP_HOME..."

if [ -n "$HADOOP_HOME" ]; then
    pass "HADOOP_HOME Configured"
    echo "$HADOOP_HOME"
else
    fail "HADOOP_HOME Not Configured"
fi

echo

echo "Checking SSH..."

if pgrep -x sshd >/dev/null; then
    pass "SSH Running"
else
    fail "SSH Not Running"
fi

eecho

echo "Waiting for services to initialize..."
sleep 3

echo
echo "Checking Hadoop Services..."

SERVICES=(
NameNode
DataNode
SecondaryNameNode
ResourceManager
NodeManager
)

for service in "${SERVICES[@]}"
do
    if jps | grep -q "$service"; then
        pass "$service Running"
    else
        fail "$service Not Running"
    fi
done

echo

echo "Checking HDFS..."

if hdfs dfs -ls / >/dev/null 2>&1; then
    pass "HDFS Accessible"
else
    fail "HDFS Not Accessible"
fi

echo

echo "Checking YARN..."

if yarn node -list >/dev/null 2>&1; then
    pass "YARN Running"
else
    fail "YARN Not Running"
fi

echo

echo "Web Interfaces"

echo "HDFS : http://localhost:9870"
echo "YARN : http://localhost:8088"

echo

echo "=================================================="
echo "Verification Complete"
echo "=================================================="
