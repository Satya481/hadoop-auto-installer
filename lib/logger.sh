#!/bin/bash

# ======================================================
# Hadoop Auto Installer v2.0
# Logger Library
# ======================================================

# Project Root Directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

LOG_DIR="$PROJECT_ROOT/logs"
LOG_FILE="$LOG_DIR/install.log"

mkdir -p "$LOG_DIR"

timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

log_info() {
    echo "[$(timestamp)] [INFO] $1" >> "$LOG_FILE"
    info "$1"
}

log_success() {
    echo "[$(timestamp)] [SUCCESS] $1" >> "$LOG_FILE"
    success "$1"
}

log_warning() {
    echo "[$(timestamp)] [WARNING] $1" >> "$LOG_FILE"
    warning "$1"
}

log_error() {
    echo "[$(timestamp)] [ERROR] $1" >> "$LOG_FILE"
    error "$1"
}

log_title() {
    echo "" >> "$LOG_FILE"
    echo "===================================================" >> "$LOG_FILE"
    echo "[$(timestamp)] $1" >> "$LOG_FILE"
    echo "===================================================" >> "$LOG_FILE"

    title "$1"
}

show_log() {
    cat "$LOG_FILE"
}

clear_log() {
    > "$LOG_FILE"
}
