# AI-Powered Security Analysis with VEX Generation

**VEX (Vulnerability Exploitability eXchange)** tells you whether vulnerabilities actually matter in your specific environment. Instead of just listing CVEs, VEX provides context about real exploitability and practical risk assessment.

## 🚨 The Problem with Traditional Vulnerability Scanning

Traditional vulnerability scanners generate overwhelming noise - reporting every CVE found in dependencies without considering whether they're actually exploitable. Security teams waste critical time triaging hundreds of theoretical vulnerabilities while real threats go unaddressed.

**Common Issues:**
- **False Positives**: Vulnerable libraries that aren't actually reachable by attackers
- **Context Blindness**: Scanners can't evaluate runtime protections, network controls, or application-specific mitigations
- **Alert Fatigue**: Teams become desensitized to constant vulnerability reports
- **Resource Misallocation**: Critical effort spent on non-exploitable CVEs instead of real security gaps

## 🎯 Why Exploitability Analysis Matters

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
2. **📋 Security Reports** - Detailed technical analysis with exploitability details and remediation guidance
3. **🔒 VEX Document** - Industry-standard OpenVEX-compliant exploitability determinations generated using the VEX Document MCP Server

**📁 Example Reports**: [docs/security/reports/](docs/security/reports/)

## Two VS Code Chat Modes

This project provides two complementary security analysis workflows as **VS Code Chat Modes** - integrated configurations that provide tailored AI behavior with predefined tools and instructions:

### 🔍 **Chat Mode 1: Security Scan & VEX Generation**
Complete security assessment workflow that scans your application, analyses exploitability, and generates standardized VEX documentation.

**Use when:** Starting security assessment from scratch or need comprehensive vulnerability analysis

### 🎯 **Chat Mode 2: Deep CVE Exploit Analysis** 
Advanced exploit analysis that takes existing security reports and creates detailed technical documentation for each CVE vulnerability.

**Use when:** You have existing security reports and need deeper technical analysis for specific CVEs

Both modes are **VS Code Chat Modes** with predefined MCP tool access, Claude Sonnet 4 model, and structured workflow instructions for a seamless integrated experience.

## Why This Approach Matters

Traditional vulnerability scanners generate overwhelming noise - reporting every CVE found in dependencies without considering actual exploitability. This project focuses on **evidence-based risk assessment** rather than theoretical vulnerability presence.

**Key Benefits:**
- **🎯 Evidence-Based Analysis**: Every determination backed by concrete technical proof
- **🔍 Beyond CVE Scanning**: Discovers application-specific vulnerabilities through OWASP Top 10 review
- **📊 Risk-Based Prioritization**: Focus resources on vulnerabilities that pose actual threat
- **📋 Industry Standards**: OpenVEX-compliant documents for transparent vulnerability communication
- **⚡ Integrated VS Code Experience**: Chat modes provide seamless workflow with automated tool access

## How VS Code Chat Modes Work

This project uses **VS Code Chat Modes** - integrated configurations that provide tailored AI behavior for specific security analysis tasks. Chat modes combine predefined instructions, tools, and AI models into a seamless workflow.

**Key Benefits:**
- **🎯 Integrated Experience**: No copy-pasting prompts - select mode from dropdown
- **🔧 Predefined Tools**: Direct access to MCP servers (Trivy, VEX Document, OSV)
- **🤖 Consistent AI Model**: Uses Claude Sonnet 4 for all analysis
- **📋 Structured Workflows**: Step-by-step guidance built into each mode

**How to Use:**
1. Open VS Code Chat view with `Ctrl+Alt+I`
2. Select your desired mode from the chat mode dropdown
3. Follow the mode's guided workflow for your security analysis

Both chat modes are **VS Code Chat Modes** with predefined MCP tool access, Claude Sonnet 4 model, and structured workflow instructions for a seamless integrated experience.

## Getting Started

### Prerequisites
- VS Code with the latest version installed
- GitHub Copilot access (Free plan available)
- The required MCP tools configured (automatically set up in dev container)

### 1️⃣ **Chat Mode 1**: Security Scan & VEX Generation

**Complete end-to-end security assessment workflow**

1. **Open VS Code Chat**: Press `Ctrl+Alt+I` to open the Chat view
2. **Select Chat Mode**: Choose "Security Scan & VEX Generation" from the chat mode dropdown
3. **Provide Details**: The chat mode will ask for:
   - **Report Name**: `my-app-security-assessment`
   - **Product Name**: `my-application`
   - **Scope**: `src/` (directories to analyze)

3. **Automated 4-Step Process**:
   - 🔍 **Comprehensive Scanning**: Trivy identifies CVEs, misconfigurations, secrets, and license issues
   - 🧠 **Exploitability Analysis**: Rigorous technical analysis determining actual exploitability
   - 🔒 **OWASP Top 10 Review**: Manual review for application-specific vulnerabilities
   - 📋 **VEX Documentation**: Generate OpenVEX-compliant industry-standard documents

**Results**: Three deliverables automatically saved to `docs/security/reports/[report-name]/`:
- 📄 **Summary** - Executive overview of critical findings
- 📋 **Security Report** - Detailed technical analysis with remediation guidance
- 🔒 **VEX Document** - Industry-standard exploitability determinations

### 2️⃣ **Chat Mode 2**: Deep CVE Exploit Analysis

**Advanced technical analysis for existing security reports**

1. **Prerequisites**: Existing security report with CVE findings (from Mode 1 or other sources)
2. **Open VS Code Chat**: Press `Ctrl+Alt+I` to open the Chat view
3. **Select Chat Mode**: Choose "Deep CVE Exploit Analysis" from the chat mode dropdown
4. **Select Report**: The chat mode will show available reports in `docs/security/reports/`

4. **7-Step Deep Analysis Process**:
   - 📊 **CVE Report Analysis**: Extract and prioritize ALL CVEs from existing reports
   - 🔍 **Intelligence Gathering**: Deep research using vulnerability databases
   - 🧩 **Library Integration Analysis**: Trace vulnerable library usage in application context
   - 🎯 **Exploit Development**: Create theoretical proof-of-concept demonstrations (documentation only)
   - 📋 **Individual CVE Documentation**: Generate detailed exploit analysis per CVE
   - ⏭️ **Progress Tracking**: Manage analysis queue and context clearing
   - 📊 **Executive Summary**: High-level overview after processing multiple CVEs

**Results**: Enhanced documentation with detailed exploit scenarios:
- � **Individual CVE Documents**: `[CVE-ID]-exploit-analysis.md` per vulnerability
- 📊 **Executive Summary**: `executive-summary-exploit-analysis.md` with business impact
- 🎯 **Prioritized Findings**: Risk-based ordering of exploitable vs non-exploitable CVEs

## Chat Modes & Instructions

- **📖 Global Instructions**: [.github/instructions/vex.instructions.md](.github/instructions/vex.instructions.md) - Applies to both chat modes
- **🔨 MCP Tools**: Ensure these MCP tools are made available to the agent.
    ![MCP tools](assets/mcp_tools.png)
- **🔍 Chat Mode 1**: [.github/chatmodes/security-scan-and-vex.chatmode.md](.github/chatmodes/security-scan-and-vex.chatmode.md)
    ![security analysis prompt](./assets/security-analysis-prompt.png)

    ![security analysis prompt example](./assets/security-analysis-prompt-example.png)

- **🎯 Chat Mode 2**: [.github/chatmodes/deep-cve-exploit-analysis.chatmode.md](.github/chatmodes/deep-cve-exploit-analysis.chatmode.md)
    ![deep cve analysis prompt](./assets/deep-cve-analysis-prompt.png)
- **📁 Example Reports**: [docs/security/reports/](docs/security/reports/)

## Setup

**Development Container**: Pre-configured with all tools and MCP servers. Simply open in VS Code with Dev Containers extension.

**Manual Setup**: If not using the dev container, install these prerequisites:

```bash
# Clone and setup
git clone <repository>
cd ai_generated_vex
make setup  # Installs all required tools

# Start MCP servers
make start-osv-mcp-server
```

**Prerequisites Required:**
- **Docker** - For OSV MCP server
- **Go** (v1.24+) - For vexctl installation
- **Node.js** (v22+) - For vexdoc-mcp installation
- **Trivy** (v0.63.0+) - Security scanner

### MCP Configuration

The following MCP servers are automatically configured in the dev container:

```json
{
    "servers": {
        "trivy-mcp": {
            "type": "stdio",
            "command": "trivy",
            "args": ["mcp"]
        },
        "vexdoc-mcp": {
            "type": "stdio",
            "command": "npx",
            "args": ["vexdoc-mcp"]
        },
        "osv-mcp": {
            "type": "http",
            "url": "http://localhost:3001/mcp"
        }
    }
}
```

### Helpful Commands

```bash
make help                  # Show all available commands
make setup                 # Install all required tools and dependencies
make start-osv-mcp-server  # Start the OSV MCP server
make stop-osv-mcp-server   # Stop the OSV MCP server
make status-osv-mcp-server # Check OSV MCP server status
```

## Documentation & Examples

- **📖 Complete Instructions**: [.github/instructions/vex.instructions.md](.github/instructions/vex.instructions.md)
- **� Security Scan Chat Mode**: [.github/chatmodes/security-scan-and-vex.chatmode.md](.github/chatmodes/security-scan-and-vex.chatmode.md)
- **🎯 CVE Analysis Chat Mode**: [.github/chatmodes/deep-cve-exploit-analysis.chatmode.md](.github/chatmodes/deep-cve-exploit-analysis.chatmode.md)
- **�📁 Example Reports**: [docs/security/reports/](docs/security/reports/)
- **🔗 VEX Specification**: [OpenVEX](https://github.com/openvex/spec)

## Related Projects

- [Trivy MCP](https://github.com/aquasecurity/trivy-mcp) - Security scanning MCP server
- [VEX Document MCP Server](https://github.com/rosstaco/vexdoc-mcp) - VEX document generation
- [OSV MCP Server](https://github.com/StacklokLabs/osv-mcp) - Vulnerability intelligence
- [Vulpy Test App](https://github.com/fportantier/vulpy) - Vulnerable Python application for testing
