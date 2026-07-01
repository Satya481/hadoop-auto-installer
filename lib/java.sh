#!/bin/bash

# ======================================================
# Hadoop Auto Installer v2.0
# Java Module
# ======================================================

check_java() {

    log_info "Checking Java..."

}

install_java() {

    info "Checking Java..."

    if java -version >/dev/null 2>&1; then

        success "Java Already Installed"

        java -version

    else
        info "Installing OpenJDK 11..."

        sudo apt update

        sudo apt install openjdk-11-jdk -y

        success "Java Installed Successfully"

    fi

}


detect_java() {

    log_info "Detecting JAVA_HOME..."

}

configure_java() {

    log_info "Configuring Java..."

}
