#!/bin/bash

source lib/colors.sh
source lib/logger.sh

clear_log

banner

log_title "Testing Logger"

log_info "Checking Internet"

sleep 1

log_success "Internet Available"

sleep 1

log_warning "Java Already Installed"

sleep 1

log_error "Dummy Error"

echo
echo "Log File Contents:"
echo

show_log
