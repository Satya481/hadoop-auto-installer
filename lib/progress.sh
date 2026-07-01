#!/bin/bash

# ======================================================
# Hadoop Auto Installer v2.0
# Progress Bar Library
# ======================================================

TOTAL_STEPS=100
BAR_WIDTH=40

progress() {

    local CURRENT=$1
    local MESSAGE="$2"

    local FILLED=$((CURRENT * BAR_WIDTH / TOTAL_STEPS))
    local EMPTY=$((BAR_WIDTH - FILLED))

    printf "\r"

    printf "["

    for ((i=0;i<FILLED;i++)); do
        printf "█"
    done

    for ((i=0;i<EMPTY;i++)); do
        printf "░"
    done

    printf "] %3d%%  %s" "$CURRENT" "$MESSAGE"

    if [ "$CURRENT" -eq 100 ]; then
        echo
    fi
}

simulate_progress() {

    local MESSAGE="$1"

    for i in 0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100
    do
        progress "$i" "$MESSAGE"
        sleep 0.05
    done
}
