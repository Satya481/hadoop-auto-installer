#!/bin/bash

HADOOP_VERSION="3.4.1"
HADOOP_HOME="$HOME_DIR/hadoop"
JAVA_HOME_PATH="/usr/lib/jvm/java-11-openjdk-amd64"
HADOOP_DATA="$HOME_DIR/hadoopdata"
DOWNLOAD_URL="https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz"

source lib/config.sh
source lib/colors.sh
source lib/logger.sh
source lib/progress.sh
source lib/common.sh
source lib/test.sh
source lib/ssh.sh
source lib/java.sh
source lib/hadoop.sh
# ======================================================
# Hadoop Auto Installer v1.0
# Author: Satyaprakash Gupta
# Supports:
#   Ubuntu 22.04+
#   Ubuntu 24.04+
#   Linux Mint
# Hadoop Version: 3.4.1
# Java Version: OpenJDK 11
# ======================================================

set -e

# ----------------------------
# Colors
# ----------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ----------------------------
# Print Functions
# ----------------------------



# ----------------------------
# Detect Current User
# ----------------------------

CURRENT_USER=$(whoami)
HOME_DIR=$HOME

# ----------------------------
# Welcome
# ----------------------------

clear

echo "==========================================="
echo "      Hadoop Auto Installer v1.0"
echo "==========================================="

info "User : $CURRENT_USER"
info "Home : $HOME_DIR"
info "Hadoop Version : $HADOOP_VERSION"

echo ""



# ======================================================
# Run Checks
# ======================================================

check_internet
check_os
install_java
install_ssh

download_hadoop
extract_hadoop


configure_bashrc

export JAVA_HOME=$JAVA_HOME_PATH
export HADOOP_HOME=$HOME/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

configure_hadoop_env
configure_core_site
configure_hdfs_site
configure_mapred_site
configure_yarn_site

configure_ssh
format_namenode
start_hadoop
verify_cluster
test_hadoop


