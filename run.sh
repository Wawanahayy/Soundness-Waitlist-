#!/bin/bash

# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# Install Rust
if ! command -v rustc &> /dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
    echo 'source $HOME/.cargo/env' >> ~/.bashrc
    source ~/.bashrc
else
    echo "Rust is already installed!"
fi

# Verify Rust installation
rustc --version
cargo --version

# Install Soundness CLI
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash
source ~/.bashrc

# Ensure Soundness CLI is in PATH
export PATH="$HOME/.soundnessup/bin:$PATH"
echo 'export PATH="$HOME/.soundnessup/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Validate installation
if ! command -v soundnessup &> /dev/null; then
    echo "❌ soundnessup command not found. Please restart your terminal and try again."
    exit 1
fi

# Install and update Soundness CLI
soundnessup install
soundnessup update

# Validate soundness-cli installation
if ! command -v soundness-cli &> /dev/null; then
    echo "❌ soundness-cli command not found. Please check the installation."
    exit 1
fi

# Generate a new key
soundness-cli generate-key --name my-key

# Display stored keys
echo -e "\n🔑 Listing all stored keys:"
soundness-cli list-keys

echo -e "\n🎉 Setup completed! Soundness CLI is ready to use."
