#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

clear

while true
do
    clear

    echo "========================================="
    echo "           Hadoop Log Viewer"
    echo "========================================="
    echo
    echo "1. Install Log"
    echo "2. Start Log"
    echo "3. Stop Log"
    echo "4. Restart Log"
    echo "5. Backup Log"
    echo "6. Restore Log"
    echo "7. Uninstall Log"
    echo "8. Exit"
    echo
    read -p "Choose an option: " CHOICE

    case $CHOICE in

        1)
            less logs/install.log
            ;;

        2)
            less logs/start-session.txt
            ;;

        3)
            less logs/stop-session.txt
            ;;

        4)
            less logs/restart-session.txt
            ;;

        5)
            less logs/backup-session.txt
            ;;

        6)
            less logs/restore-session.txt
            ;;

        7)
            less logs/uninstall-session.txt
            ;;

        8)
            exit 0
            ;;

        *)
            echo
            echo "Invalid choice."
            sleep 2
            ;;

    esac

done
