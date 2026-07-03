#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"
# ==========================================
# Hadoop Auto Installer
# Start Hadoop Services
# ==========================================


source "$SCRIPT_DIR/lib/colors.sh"
source "$SCRIPT_DIR/lib/logger.sh"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/hadoop.sh"
banner

log_info "Starting Hadoop Services..."

start_hadoop

echo

log_success "Hadoop Started Successfully"

echo
echo "Web Interfaces"
echo "--------------------------------------"
echo "HDFS : http://localhost:9870"
echo "YARN : http://localhost:8088"

echo
jps
