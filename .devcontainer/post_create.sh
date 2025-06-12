#!/bin/bash

# This script is executed after the container is created.
git submodule init
git submodule update

# Define the path to your Zsh profile
zshrc_path="$HOME/.zshrc"
bashrc_path="$HOME/.bashrc"

echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$zshrc_path"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$bashrc_path"

cat $HOME/.zshrc
export PATH="$HOME/.local/bin:$PATH"

# Install Trivy
export TRIVY_VERSION=0.63.0
wget https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.deb
sudo dpkg -i trivy_${TRIVY_VERSION}_Linux-64bit.deb
rm trivy_${TRIVY_VERSION}_Linux-64bit.deb

# Install Trivy plugins
trivy plugin install mcp
bash -c "nohup trivy mcp --transport sse --port 8080 > trivy.log 2>&1 &"

# Install CVE Search
cd mcp_servers/cve-search_mcp && uv sync