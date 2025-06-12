#!/bin/bash

# Define the path to your Zsh profile
zshrc_path="$HOME/.zshrc"
bashrc_path="$HOME/.bashrc"

echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$zshrc_path"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$bashrc_path"

cat $HOME/.zshrc
export PATH="$HOME/.local/bin:$PATH"

# Install Trivy
wget https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.deb
sudo dpkg -i trivy_0.18.3_Linux-64bit.deb
rm trivy_0.18.3_Linux-64bit.deb

# Install Trivy plugins
trivy plugin install mcp