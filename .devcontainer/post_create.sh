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

# Add Go user bin to PATH
export PATH="$HOME/go/bin:$PATH"
echo 'export PATH="$HOME/go/bin:$PATH"' >> "$zshrc_path"
echo 'export PATH="$HOME/go/bin:$PATH"' >> "$bashrc_path"

# Install Trivy plugins
trivy plugin install mcp

# Install vexctl
go install github.com/openvex/vexctl@v0.3.0

# Install vexdoc MCP Server from prebuilt release
ARCH=$(uname -m)
OS=$(uname -s)

# Map architecture names to match release naming
case "$ARCH" in
    aarch64)
        ARCH="arm64"
        ;;
esac

# Capitalize OS for release naming convention (Linux, Darwin, Windows)
case "$OS" in
    Linux|Darwin|MINGW*|MSYS*|CYGWIN*)
        if [[ "$OS" == MINGW* ]] || [[ "$OS" == MSYS* ]] || [[ "$OS" == CYGWIN* ]]; then
            OS="Windows"
        fi
        ;;
esac

# Fetch the latest release download URL from GitHub API
echo "Fetching latest vexdoc-mcp-server release for ${OS}_${ARCH}..."
DOWNLOAD_URL=$(curl -s https://api.github.com/repos/rosstaco/vexdoc-mcp/releases/latest | \
    grep "browser_download_url.*${OS}_${ARCH}.tar.gz" | \
    cut -d '"' -f 4)

if [ -z "$DOWNLOAD_URL" ]; then
    echo "❌ Failed to find download URL for ${OS}_${ARCH}"
    exit 1
fi

echo "Downloading vexdoc-mcp-server from ${DOWNLOAD_URL}"
curl -L -o /tmp/vexdoc-mcp.tar.gz "$DOWNLOAD_URL"
tar -xzf /tmp/vexdoc-mcp.tar.gz -C /tmp
mkdir -p "$HOME/go/bin"
mv /tmp/vexdoc-mcp-server "$HOME/go/bin/vexdoc-mcp"
chmod +x "$HOME/go/bin/vexdoc-mcp"
rm -f /tmp/vexdoc-mcp.tar.gz

echo "✅ Post-create script completed successfully."