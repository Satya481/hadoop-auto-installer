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

format_namenode() {

    info "Formatting NameNode..."

    export JAVA_HOME=$JAVA_HOME_PATH
    export HADOOP_HOME=$HOME_DIR/hadoop
    export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

    if [ ! -d "$HOME_DIR/hadoopdata/hdfs/namenode/current" ]; then

        hdfs namenode -format -force

    else

        warning "NameNode Already Formatted"

    fi

}
start_hadoop() {

    info "Checking Hadoop services..."

    export JAVA_HOME=$JAVA_HOME_PATH
    export HADOOP_HOME=$HOME_DIR/hadoop
    export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

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

