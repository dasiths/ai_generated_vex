# Security Vulnerability Assessment with VEX Generation

**VEX (Vulnerability Exploitability eXchange)** tells you whether vulnerabilities actually matter in your specific environment. Instead of just listing CVEs, VEX provides context about real exploitability.

## The Problem with Traditional Vulnerability Scanning

Traditional vulnerability scanners generate overwhelming noise - reporting every CVE found in dependencies without considering whether they're actually exploitable. Security teams waste critical time triaging hundreds of theoretical vulnerabilities while real threats go unaddressed.

**Common Issues:**
- **False Positives**: Vulnerable libraries that aren't actually reachable by attackers
- **Context Blindness**: Scanners can't evaluate runtime protections, network controls, or application-specific mitigations
- **Alert Fatigue**: Teams become desensitized to constant vulnerability reports
- **Resource Misallocation**: Critical effort spent on non-exploitable CVEs instead of real security gaps

## Why Exploitability Analysis Matters

This workflow addresses fundamental gaps in traditional security assessment by focusing on **actual risk** rather than theoretical vulnerability presence. The exploitability analysis phase performs deep technical investigation that answers the critical question: "Can an attacker actually exploit this in our specific environment?"

**Technical Depth Required:**
- **Code Reachability Analysis**: Tracing execution paths from entry points to vulnerable functions
- **Attack Surface Mapping**: Identifying realistic attack vectors and prerequisites  
- **Environmental Context**: Evaluating protective controls, deployment configurations, and runtime defenses
- **Exploitation Feasibility**: Assessing real-world conditions needed for successful attacks

**Beyond CVE Catalogs:**
While CVE databases document known vulnerabilities, they can't evaluate your specific implementation context. A CVE marked "Critical" may be completely unexploitable due to how your application is architected, deployed, or protected. Conversely, application-specific vulnerabilities not captured in any CVE database may pose significant risk.

**Supply Chain Transparency:**
VEX documents provide standardized communication about vulnerability status across development teams, security organizations, and third-party vendors. Instead of blanket vulnerability reports, stakeholders receive evidence-based determinations about actual risk exposure.

## What You Get

This automated workflow generates three comprehensive security deliverables:

1. **📄 Summary** - Executive overview of critical findings
2. **📋 Security Report** - Detailed technical analysis with remediation guidance  
3. **🔒 VEX Document** - Industry-standard OpenVEX-compliant exploitability determinations generated using the VEX Document MCP Server

**📁 Example Reports**: [docs/security/reports/](docs/security/reports/) | **📖 Full Instructions**: [.github/instructions/vex.instructions.md](.github/instructions/vex.instructions.md)

## How It Works

**4-Step Automated Workflow:**

### 1. 🔍 Comprehensive Scanning 
Trivy MCP identifies CVEs, misconfigurations, secrets, and license issues across dependencies and infrastructure.

### 2. 🧠 Exploitability Analysis *(Critical Step)*
The most important phase - rigorous technical analysis determining whether each CVE is actually exploitable:
- **Code Path Tracing**: Map complete execution flows from entry points to vulnerable code
- **Attack Prerequisites**: Evaluate authentication, network access, and input validation barriers  
- **Environmental Protections**: Assess runtime defenses, deployment controls, and monitoring capabilities
- **Evidence Collection**: Document concrete technical proof for every exploitability determination

### 3. 🔒 OWASP Top 10 Review
Systematic manual review discovering application-specific vulnerabilities beyond known CVEs:
- Business logic flaws not captured in vulnerability databases
- Implementation-specific security issues
- Configuration and deployment vulnerabilities
- Custom code security patterns

### 4. 📋 Comprehensive Documentation
Generate three industry-standard deliverables with complete technical analysis and evidence-based conclusions. VEX documents are created using the VEX Document MCP Server to ensure OpenVEX compliance and standardized vulnerability communication.

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

**🎯 Evidence-Based Analysis**: Every vulnerability determination backed by concrete technical proof and detailed reasoning  
**🔍 Beyond CVE Scanning**: Discovers application-specific vulnerabilities through systematic OWASP Top 10 review  
**📊 Risk-Based Prioritization**: Focus security resources on vulnerabilities that pose actual threat in your environment  
**📋 Industry Standards**: OpenVEX-compliant documents generated using the VEX Document MCP Server, enabling transparent vulnerability communication across teams and vendors  
**🔬 Technical Rigor**: Exploitability analysis performed with penetration testing-level depth and documentation  
**⚡ Automation with Intelligence**: Combines automated scanning tools with human-level security analysis reasoning

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
        "type": "stdio",
        "command": "trivy",
        "args": ["mcp"]
      },
      "Trivy MCP SSE": {
        "type": "sse",
        "url": "http://localhost:8080/sse"
      },
      "vexdoc-mcp": {
        "type": "stdio",
        "command": "npx",
        "args": ["vexdoc-mcp"]
      },
      "cve-search_mcp": {
        "type": "stdio",
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
- [VEX Document MCP Server](https://github.com/rosstaco/vexdoc-mcp)
- [CVE Search MCP](https://github.com/roadwy/cve-search_mcp) 
- [Vulpy Test App](https://github.com/fportantier/vulpy)