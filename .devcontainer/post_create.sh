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

# Install Trivy plugins
trivy plugin install mcp

# Install CVE Search
cd mcp_servers/cve-search_mcp && uv sync

# Install vexctl
go install github.com/openvex/vexctl@latest

# Install vexdoc MCP Server
npm install -g https://github.com/rosstaco/vexdoc-mcp/releases/download/0.0.1-pre-release/vexdoc-mcp-0.0.1.tgz

echo "✅ Post-create script completed successfully."