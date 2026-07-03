#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

source "$SCRIPT_DIR/lib/colors.sh"
source "$SCRIPT_DIR/lib/logger.sh"
banner

log_info "Stopping Hadoop..."

stop-yarn.sh
stop-dfs.sh

echo
log_success "Hadoop Stopped"

echo
jps
