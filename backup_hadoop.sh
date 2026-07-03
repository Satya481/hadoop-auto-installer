#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

source "$SCRIPT_DIR/lib/colors.sh"
source "$SCRIPT_DIR/lib/logger.sh"

banner

log_info "Creating Hadoop Backup..."

BACKUP_DIR="$SCRIPT_DIR/backups"

mkdir -p "$BACKUP_DIR"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

BACKUP_NAME="hadoop_backup_$DATE.tar.gz"

log_info "Backing up Hadoop installation..."

tar -czf "$BACKUP_DIR/$BACKUP_NAME" \
"$HOME/hadoop" \
"$HOME/.bashrc" \
"$HOME/hadoopdata" \
"$SCRIPT_DIR/config" \
2>/dev/null

echo

log_success "Backup Created"

echo
echo "Location : $BACKUP_DIR/$BACKUP_NAME"

echo
echo "Size"

du -h "$BACKUP_DIR/$BACKUP_NAME"
