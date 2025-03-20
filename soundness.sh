#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Soundness CLI
install_cli() {
    echo "Installing Soundness CLI..."
    curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash
    
    # Detect shell and source the appropriate file
    if [[ "$SHELL" == *"zsh"* ]]; then
        echo "Sourcing ~/.zshenv..."
        source ~/.zshenv
    else
        echo "Sourcing ~/.bashrc..."
        source ~/.bashrc
    fi
    
    echo "Installation complete!"
}

# Generate or import a key
setup_keys() {
    echo "Do you want to (1) Generate a new key or (2) Import an existing one?"
    read -p "Enter 1 or 2: " choice
    
    if [ "$choice" == "1" ]; then
        read -p "Enter a name for your key: " key_name
        soundness-cli generate-key --name "$key_name"
    elif [ "$choice" == "2" ]; then
        read -p "Enter a name for your key: " key_name
        soundness-cli import-key --name "$key_name"
    else
        echo "Invalid choice. Skipping key setup."
    fi
}

# Main execution
install_cli
setup_keys

echo "Setup completed! Run 'soundness-cli list-keys' to check your keys."
