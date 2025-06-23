#!/bin/bash

# Start the OSV MCP server
pushd mcp_servers/osv-mcp || exit
docker-compose up -d || exit
popd || exit