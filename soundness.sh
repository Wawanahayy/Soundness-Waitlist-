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

# Generate or import a key with input validation
setup_keys() {
    while true; do
        echo "Do you want to (1) Generate a new key or (2) Import an existing one?"
        read -p "Enter 1 or 2 (default is 1): " choice
        choice=${choice:-1}  # Default to 1 if empty

        if [ "$choice" == "1" ]; then
            read -p "Enter a name for your key: " key_name
            soundness-cli generate-key --name "$key_name"
            break
        elif [ "$choice" == "2" ]; then
            read -p "Enter a name for your key: " key_name
            soundness-cli import-key --name "$key_name"
            break
        else
            echo "❌ Invalid choice. Please enter 1 or 2."
        fi
    done
    
    echo "\n🔑 Listing all stored keys:"
    soundness-cli list-keys
}

# Main execution
install_cli
setup_keys

echo "\n🎉 Setup completed! Run 'soundness-cli list-keys' anytime to check your keys."
