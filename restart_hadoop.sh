#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"
source "$SCRIPT_DIR/lib/colors.sh"
source "$SCRIPT_DIR/lib/logger.sh"

banner

log_info "Restarting Hadoop..."

./stop_hadoop.sh

sleep 2

./start_hadoop.sh

echo
log_success "Restart Completed"
