# Setup ssh
setup_ssh() {
    if [[ $SSH_PUBLIC_KEY ]]; then
        echo "Setting up SSH..."
        mkdir -p ~/.ssh
        echo "$SSH_PUBLIC_KEY" >> ~/.ssh/authorized_keys
        chmod 700 -R ~/.ssh

        ssh-keygen -A       # regenerate new keys
        service ssh start
    fi
}

setup_ssh
bash "/start.sh"