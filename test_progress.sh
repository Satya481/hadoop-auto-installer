#!/bin/bash

source lib/colors.sh
source lib/progress.sh

banner

simulate_progress "Installing Java"

sleep 1

simulate_progress "Configuring Hadoop"

sleep 1

simulate_progress "Starting HDFS"

sleep 1

simulate_progress "Running WordCount"

echo
success "Installation Completed"

