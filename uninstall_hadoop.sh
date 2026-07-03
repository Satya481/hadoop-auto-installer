#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

source "$SCRIPT_DIR/lib/colors.sh"
source "$SCRIPT_DIR/lib/logger.sh"

banner

echo
echo "==========================================="
echo "          Hadoop Uninstaller"
echo "==========================================="
echo

echo "This will remove:"
echo "✔ Hadoop Installation"
echo "✔ HDFS Data"
echo "✔ Hadoop Environment Variables"
echo

read -p "Type YES to continue: " CONFIRM

if [ "$CONFIRM" != "YES" ]; then
    log_warning "Uninstallation Cancelled."
    exit 0
fi

log_info "Stopping Hadoop..."

stop-yarn.sh >/dev/null 2>&1
stop-dfs.sh >/dev/null 2>&1

echo

log_info "Removing Hadoop..."

rm -rf "$HOME/hadoop"

echo

log_info "Removing Hadoop Data..."

rm -rf "$HOME/hadoopdata"

echo

log_info "Cleaning .bashrc..."

sed -i '/# Hadoop Environment/,+10d' "$HOME/.bashrc"

echo

read -p "Delete backups? (y/n): " DELETE_BACKUP

if [ "$DELETE_BACKUP" = "y" ]; then

    rm -rf "$SCRIPT_DIR/backups"

    log_success "Backups Deleted"

else

    log_info "Backups Preserved"

fi

echo

log_success "Hadoop Uninstalled Successfully"
