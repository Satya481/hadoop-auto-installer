#!/bin/bash

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

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# ----------------------------
# Detect Current User
# ----------------------------

CURRENT_USER=$(whoami)
HOME_DIR=$HOME

# ----------------------------
# Hadoop Variables
# ----------------------------

HADOOP_VERSION="3.4.1"

HADOOP_HOME="$HOME_DIR/hadoop"

JAVA_HOME_PATH="/usr/lib/jvm/java-11-openjdk-amd64"

HADOOP_DATA="$HOME_DIR/hadoopdata"

DOWNLOAD_URL="https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz"

# ----------------------------
# Welcome
# ----------------------------

clear

echo "==========================================="
echo "      Hadoop Auto Installer v1.0"
echo "==========================================="

echo ""

info "User : $CURRENT_USER"
info "Home : $HOME_DIR"
info "Hadoop Version : $HADOOP_VERSION"

echo ""
# ======================================================
# Check Internet Connection
# ======================================================

check_internet() {

    info "Checking Internet Connection..."

    if ping -c 1 google.com >/dev/null 2>&1
    then
        success "Internet Connection Available"
    else
        error "No Internet Connection."
        exit 1
    fi
}

# ======================================================
# Check Operating System
# ======================================================

check_os() {

    info "Checking Operating System..."

    if [ -f /etc/os-release ]; then

        . /etc/os-release

        echo "Detected OS : $PRETTY_NAME"

    else

        error "Unsupported Linux Distribution"

        exit 1

    fi
}

# ======================================================
# Install Java 11
# ======================================================

install_java() {

    info "Checking Java..."

    if java -version >/dev/null 2>&1; then

        success "Java Already Installed"

        java -version

    else
        info "Installing OpenJDK 11..."

        sudo apt update

        sudo apt install openjdk-11-jdk -y

        success "Java Installed Successfully"

    fi

}

# ======================================================
# Install SSH
# ======================================================

install_ssh() {

    info "Checking SSH..."

    if command -v ssh >/dev/null 2>&1; then

        success "SSH Already Installed"

    else

        info "Installing SSH..."

        sudo apt install openssh-server openssh-client -y

        success "SSH Installed"

    fi

}

# ======================================================
# Run Checks
# ======================================================

check_internet
check_os
install_java
install_ssh

# ======================================================
# Download Hadoop
# ======================================================

download_hadoop() {

    info "Checking Hadoop Installation..."

    if [ -d "$HADOOP_HOME" ]; then

        success "Hadoop already exists at $HADOOP_HOME"

        return

    fi

    if [ -f "hadoop-${HADOOP_VERSION}.tar.gz" ]; then

        success "Found local Hadoop archive."

    else

        info "Downloading Hadoop..."

        wget -O hadoop-${HADOOP_VERSION}.tar.gz "$DOWNLOAD_URL"

    fi

}

# ======================================================
# Extract Hadoop
# ======================================================

extract_hadoop() {

    if [ -d "$HADOOP_HOME" ]; then

        success "Skipping Extraction."

        return

    fi

    info "Extracting Hadoop..."

    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz

    mv hadoop-${HADOOP_VERSION} "$HADOOP_HOME"

    success "Hadoop Installed."

}

# ======================================================
# Configure Environment Variables
# ======================================================

configure_bashrc() {

    info "Configuring .bashrc"

    grep -q "HADOOP_HOME" ~/.bashrc || cat <<EOF >> ~/.bashrc

# Hadoop Environment

export JAVA_HOME=$JAVA_HOME_PATH

export HADOOP_HOME=\$HOME/hadoop

export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin

export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop

export HDFS_NAMENODE_USER=$CURRENT_USER
export HDFS_DATANODE_USER=$CURRENT_USER
export HDFS_SECONDARYNAMENODE_USER=$CURRENT_USER
export YARN_RESOURCEMANAGER_USER=$CURRENT_USER
export YARN_NODEMANAGER_USER=$CURRENT_USER

EOF

    source ~/.bashrc

    success ".bashrc Updated"

}

download_hadoop
extract_hadoop
configure_bashrc
configure_hadoop_env() {

    info "Configuring hadoop-env.sh..."

    sed -i "s|^export JAVA_HOME=.*|export JAVA_HOME=$JAVA_HOME_PATH|" \
    "$HADOOP_HOME/etc/hadoop/hadoop-env.sh"

    success "hadoop-env.sh configured"

}
configure_core_site() {

cat > "$HADOOP_HOME/etc/hadoop/core-site.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>

</configuration>
EOF

success "core-site.xml configured"

}

configure_hdfs_site() {

mkdir -p "$HOME_DIR/hadoopdata/hdfs/namenode"
mkdir -p "$HOME_DIR/hadoopdata/hdfs/datanode"

cat > "$HADOOP_HOME/etc/hadoop/hdfs-site.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>

    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file://$HOME_DIR/hadoopdata/hdfs/namenode</value>
    </property>

    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file://$HOME_DIR/hadoopdata/hdfs/datanode</value>
    </property>

</configuration>
EOF

success "hdfs-site.xml configured"

}

configure_mapred_site() {

cat > "$HADOOP_HOME/etc/hadoop/mapred-site.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>

    <property>
        <name>yarn.app.mapreduce.am.env</name>
        <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>
    </property>

    <property>
        <name>mapreduce.map.env</name>
        <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>
    </property>

    <property>
        <name>mapreduce.reduce.env</name>
        <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>
    </property>

</configuration>
EOF

success "mapred-site.xml configured"

}

configure_yarn_site() {

cat > "$HADOOP_HOME/etc/hadoop/yarn-site.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>

</configuration>
EOF

success "yarn-site.xml configured"

}




configure_hadoop_env
configure_core_site
configure_hdfs_site
configure_mapred_site


configure_ssh() {

    info "Configuring Passwordless SSH..."

    sudo apt install openssh-server -y >/dev/null 2>&1

    mkdir -p ~/.ssh

    if [ ! -f ~/.ssh/id_rsa ]; then
        ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
    fi

    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

    chmod 600 ~/.ssh/authorized_keys

    sudo systemctl enable ssh >/dev/null 2>&1

    sudo systemctl start ssh

    ssh-keyscan -H localhost >> ~/.ssh/known_hosts 2>/dev/null

    success "SSH Configured"

}


format_namenode() {

    info "Formatting NameNode..."

    if [ ! -d "$HOME_DIR/hadoopdata/hdfs/namenode/current" ]; then

        hdfs namenode -format -force

    else

        warning "NameNode Already Formatted"

    fi

}

start_hadoop() {

    info "Checking Hadoop services..."

    if jps | grep -q NameNode; then
        warning "HDFS is already running."
    else
        info "Starting HDFS..."
        start-dfs.sh
    fi

    if jps | grep -q ResourceManager; then
        warning "YARN is already running."
    else
        info "Starting YARN..."
        start-yarn.sh
    fi

    success "Hadoop services checked."

}


verify_cluster() {

    info "Checking Hadoop Services..."

    jps

}


test_hadoop() {

    info "Running Hadoop Test..."

    # Remove existing input (file or directory)
    hdfs dfs -rm -r -f /input >/dev/null 2>&1

    # Create fresh input directory
    hdfs dfs -mkdir /input

    echo "Hello Hadoop Hello World Hadoop" > ~/sample.txt

    hdfs dfs -put ~/sample.txt /input

    # Remove previous output if it exists
    hdfs dfs -rm -r -f /output >/dev/null 2>&1

    hadoop jar \
    "$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.4.1.jar" \
    wordcount /input /output

    echo ""

    success "WordCount Result"

    hdfs dfs -cat /output/part-r-00000
}




configure_ssh
format_namenode
start_hadoop
verify_cluster
test_hadoop


