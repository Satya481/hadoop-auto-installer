#!/bin/bash

# ======================================================
# Hadoop Auto Installer v2.0
# Common Functions
# ======================================================

CURRENT_USER=$(whoami)
HOME_DIR=$HOME
HOST_NAME=$(hostname)

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

HADOOP_VERSION="3.4.1"

HADOOP_HOME="$HOME_DIR/hadoop"

JAVA11_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

HADOOP_DATA="$HOME_DIR/hadoopdata"

HADOOP_DOWNLOAD="https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz"

# ======================================================
# Operating System
# ======================================================

check_os() {

    log_info "Checking Operating System..."

    if [ -f /etc/os-release ]; then

        source /etc/os-release

        log_success "Detected: $PRETTY_NAME"

    else

        log_error "Unsupported Linux Distribution."

        exit 1

    fi

}

# ======================================================
# Internet
# ======================================================

check_internet() {

    log_info "Checking Internet Connection..."

    if ping -c 1 google.com >/dev/null 2>&1; then

        log_success "Internet Connection Available"

    else

        log_error "No Internet Connection"

        exit 1

    fi

}

# ======================================================
# Header
# ======================================================

show_header() {

    banner

    echo "User           : $CURRENT_USER"

    echo "Hostname       : $HOST_NAME"

    echo "Home Directory : $HOME_DIR"

    echo "Hadoop Version : $HADOOP_VERSION"

    echo

}
