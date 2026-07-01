
# ======================================================
# Install SSH
# ======================================================

install_ssh() {

    info "Checking SSH..."

    if command -v ssh >/dev/null 2>&1; then

        success "SSH Already Installed"

    else

        info "Installing SSH..."

        sudo apt install openssh-server openssh-client -y

        success "SSH Installed"

    fi

}

configure_ssh() {

    info "Configuring Passwordless SSH..."

    sudo apt install openssh-server -y >/dev/null 2>&1

    mkdir -p ~/.ssh

    if [ ! -f ~/.ssh/id_rsa ]; then
        ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
    fi

    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

    chmod 600 ~/.ssh/authorized_keys

    sudo systemctl enable ssh >/dev/null 2>&1

    sudo systemctl start ssh

    ssh-keyscan -H localhost >> ~/.ssh/known_hosts 2>/dev/null

    success "SSH Configured"

}

