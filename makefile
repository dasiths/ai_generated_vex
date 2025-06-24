start-osv-mcp-server:
	cd mcp_servers/osv-mcp && docker-compose up -d

stop-osv-mcp-server:
	cd mcp_servers/osv-mcp && docker-compose down

status-osv-mcp-server:
	cd mcp_servers/osv-mcp && docker-compose ps

logs-osv-mcp-server:
	cd mcp_servers/osv-mcp && docker-compose logs -f

setup:
	@echo "Setting up AI Generated VEX project..."
	git submodule init && git submodule update
	trivy plugin install mcp
	go install github.com/openvex/vexctl@v0.3.0
	npm install -g https://github.com/rosstaco/vexdoc-mcp/releases/download/0.0.1-pre-release/vexdoc-mcp-0.0.1.tgz
	@echo "✅ Setup completed successfully"

help:
	@echo "Available commands:"
	@echo "  setup                  - Install all required tools and dependencies"
	@echo "  start-osv-mcp-server  - Start the OSV MCP server"
	@echo "  stop-osv-mcp-server   - Stop the OSV MCP server"
	@echo "  status-osv-mcp-server - Check OSV MCP server status"
	@echo "  logs-osv-mcp-server   - View OSV MCP server logs"
	@echo "  help                  - Show this help message"

.PHONY: start-osv-mcp-server stop-osv-mcp-server status-osv-mcp-server logs-osv-mcp-server setup help