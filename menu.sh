#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

clear

while true
do
    clear

    echo "====================================================="
    echo "           Hadoop Auto Installer v2.3"
    echo "====================================================="
    echo
    echo " 1. Install Hadoop"
    echo " 2. Start Hadoop"
    echo " 3. Stop Hadoop"
    echo " 4. Restart Hadoop"
    echo " 5. Hadoop Status"
    echo " 6. Backup Hadoop"
    echo " 7. Restore Hadoop"
    echo " 8. Uninstall Hadoop"
    echo " 9. Verify Hadoop"
    echo "10. View Install Log"
    echo "11. Exit"
    echo
    echo "====================================================="
    read -p "Enter your choice [1-11]: " CHOICE

    echo

    case $CHOICE in

        1)
            ./install_hadoop.sh
            ;;

        2)
            ./start_hadoop.sh
            ;;

        3)
            ./stop_hadoop.sh
            ;;

        4)
            ./restart_hadoop.sh
            ;;

        5)
            ./status_hadoop.sh
            ;;

        6)
            ./backup_hadoop.sh
            ;;

        7)
            ./restore_hadoop.sh
            ;;

        8)
            ./uninstall_hadoop.sh
            ;;

        9)
            ./verify_hadoop.sh
            ;;

        10)
            if [ -f logs/install.log ]; then
                less logs/install.log
            else
                echo "Install log not found."
            fi
            ;;

        11)
            echo
            echo "Thank you for using Hadoop Auto Installer."
            exit 0
            ;;

        *)
            echo
            echo "Invalid choice."
            ;;

    esac

    echo
    read -p "Press Enter to return to the menu..."

done
