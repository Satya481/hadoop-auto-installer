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

