
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
