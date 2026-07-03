#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

source "$SCRIPT_DIR/lib/colors.sh"
source "$SCRIPT_DIR/lib/logger.sh"

banner

BACKUP_DIR="$SCRIPT_DIR/backups"

if [ ! -d "$BACKUP_DIR" ]; then
    log_error "Backup directory not found."
    exit 1
fi

BACKUPS=("$BACKUP_DIR"/*.tar.gz)

if [ ! -e "${BACKUPS[0]}" ]; then
    log_error "No backups found."
    exit 1
fi

echo
echo "Available Backups"
echo "-----------------------------------------"

select BACKUP in "${BACKUPS[@]}"; do

    if [ -n "$BACKUP" ]; then

        echo
        echo "Selected:"
        echo "$(basename "$BACKUP")"

        echo
        read -p "Restore this backup? (y/n): " CONFIRM

        if [[ "$CONFIRM" != "y" ]]; then
            log_warning "Restore cancelled."
            exit 0
        fi

        log_info "Stopping Hadoop..."

        stop-yarn.sh >/dev/null 2>&1
        stop-dfs.sh >/dev/null 2>&1

        log_info "Restoring files..."

        tar -xzf "$BACKUP" -C /

        echo

        log_success "Backup Restored Successfully"

        echo

        read -p "Start Hadoop now? (y/n): " START

        if [[ "$START" == "y" ]]; then

            start-dfs.sh
            start-yarn.sh

            echo

            log_success "Hadoop Started"

            jps

        fi

        exit 0

    else

        log_warning "Invalid selection."

    fi

done
