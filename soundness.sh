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
    
    # Validate installation
    if ! command_exists soundness-cli; then
        echo "❌ Installation failed or soundness-cli is not in PATH. Try running: source ~/.bashrc"
        exit 1
    fi
    
    echo "✅ Installation complete!"
}

# Generate or import a key with input validation
setup_keys() {
    local choice=""
    while [[ "$choice" != "1" && "$choice" != "2" ]]; do
        echo "Do you want to:"
        echo "1) Generate a new key"
        echo "2) Import an existing key"
        read -rp "Enter 1 or 2: " choice
    done
    
    read -rp "Enter a name for your key: " key_name
    
    if [[ "$choice" == "1" ]]; then
        soundness-cli generate-key --name "$key_name"
    else
        soundness-cli import-key --name "$key_name"
    fi
    
    echo -e "\n🔑 Listing all stored keys:"
    soundness-cli list-keys
}

# Main execution
install_cli
setup_keys

echo -e "\n🎉 Setup completed! Run 'soundness-cli list-keys' anytime to check your keys."
