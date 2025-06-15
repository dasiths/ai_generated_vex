# Security Vulnerability Assessment with VEX Generation

**VEX (Vulnerability Exploitability eXchange)** tells you whether vulnerabilities actually matter in your specific environment. Instead of just listing CVEs, VEX provides context about real exploitability.

## What You Get

This automated workflow generates three comprehensive security deliverables:

1. **📄 Summary** - Executive overview of critical findings
2. **📋 Security Report** - Detailed technical analysis with remediation guidance  
3. **🔒 VEX Document** - Industry-standard exploitability determinations

**📁 Example Reports**: [docs/security/reports/](docs/security/reports/) | **📖 Full Instructions**: [.github/instructions/vex.instructions.md](.github/instructions/vex.instructions.md)

## How It Works

**4-Step Automated Workflow:**
1. **🔍 Scan** - Find CVEs, misconfigurations, secrets, licenses
2. **🧠 Analyze** - Determine if vulnerabilities are actually exploitable *(Critical Step)*
3. **🔒 Review** - Discover application-specific security issues beyond CVEs
4. **📋 Document** - Generate comprehensive security assessment reports

## Quick Start

### 1. Provide Required Information
GitHub Copilot will ask for three details before starting:
- **Report Name**: `my-app-security-assessment`
- **Product Name**: `my-application`
- **Scope**: `src/` (directories to analyze)

### 2. Start Assessment
```
Perform a security assessment and generate VEX documentation.

Report Name: my-app-assessment
Product: my-application
Scope: src/
```

### 3. Get Results
All deliverables automatically saved to: `docs/security/reports/[report-name]/`

**That's it!** Copilot handles the complex 4-step analysis workflow automatically.

## Key Features

**🎯 Evidence-Based Analysis**: Every vulnerability determination backed by concrete technical proof  
**🔍 Beyond CVE Scanning**: Discovers application-specific vulnerabilities through OWASP Top 10 review  
**📊 Risk Prioritization**: Focus on vulnerabilities that actually matter in your environment  
**📋 Compliance Ready**: Industry-standard VEX documents for supply chain transparency

## Setup

```bash
git clone <repository>
cd ai_generated_vex
git submodule init && git submodule update

# Start Trivy MCP Server
cd mcp_servers/trivy
./start-trivy-server.sh
```

**MCP Configuration** for GitHub Copilot:
```json
{
  "mcp": {
    "servers": {
      "Trivy MCP": {
        "command": "trivy",
        "args": ["mcp"]
      },
      "cve-search_mcp": {
        "command": "uv",
        "args": ["--directory", "mcp_servers/cve-search_mcp", "run", "main.py"]
      }
    }
  }
}
```

## Documentation & Examples

- **📖 Complete Instructions**: [.github/instructions/vex.instructions.md](.github/instructions/vex.instructions.md)
- **📁 Example Reports**: [docs/security/reports/](docs/security/reports/)
- **🔗 VEX Specification**: [OpenVEX](https://github.com/openvex/spec)

## Links
- [Trivy MCP](https://github.com/aquasecurity/trivy-mcp)
- [CVE Search MCP](https://github.com/roadwy/cve-search_mcp) 
- [Vulpy Test App](https://github.com/fportantier/vulpy)