# Security Vulnerability Assessment with VEX Generation

## What is VEX?

**VEX (Vulnerability Exploitability eXchange)** tells you whether a vulnerability actually matters in your specific environment. Rather than just listing CVEs, VEX provides context about real exploitability.

**Key VEX Statuses:**
- **Not Affected**: Vulnerability exists but can't be exploited in your environment
- **Affected**: Vulnerability can be exploited in your environment
- **Fixed**: A patch has been applied
- **Under Investigation**: Still analyzing

**Benefits:**
- Reduces false alarms
- Improves supply chain transparency
- Meets regulatory requirements
- Provides actionable security intelligence

## Overview

This project provides tools and guidelines for:
1. Finding security vulnerabilities in your code
2. Determining if they're actually exploitable
3. Generating standardized VEX documents

For complete documentation, see our [detailed instructions](.github/instructions/vex.instructions.md).

## How It Works

Our approach uses three simple steps:

1. **Scan**: Use Trivy to automatically find vulnerabilities
2. **Analyze**: Review code manually to identify security issues
3. **Document**: Generate VEX reports showing what matters and why

## Quick Start Guide with GitHub Copilot

This entire workflow is powered by GitHub Copilot in Agent mode, which orchestrates the security assessment process for you.

### Step 1: Start a Copilot Chat Session
In VS Code, start a GitHub Copilot Chat session and use the prompt below to begin the security assessment:

```
Perform a security review of the src/vulpy folder and generate a VEX document.
```

### Step 2: GitHub Copilot Agent Process

Copilot Agent will automatically:

1. **Scan for Vulnerabilities**
   - Use the Trivy MCP server to identify potential issues
   - Analyze dependencies, code, and configurations

2. **Review Code for Security Issues**
   - Examine input validation, authentication, encryption
   - Check for common vulnerabilities like XSS, SQL injection
   - Analyze error handling and third-party dependencies

3. **Analyze Exploitability**
   - Determine if vulnerable code is actually reachable
   - Check if attack vectors exist in your environment
   - Evaluate mitigating controls and security measures

4. **Generate VEX Document**
   - Create a standardized report explaining which vulnerabilities matter
   - Provide justifications for each vulnerability status
   - Store the document in the proper location

You can simply chat with GitHub Copilot while it handles the complex assessment process for you.

For detailed guidance on each step, consult our [comprehensive assessment guide](.github/instructions/vex.instructions.md).

## VEX Document Example

Here's a simplified example of a VEX document:

```json
{
  "@context": "https://openvex.dev/ns/v0.2.0",
  "author": "Security Team",
  "timestamp": "2025-06-13T14:00:00Z",
  "product": {
    "@id": "example-app-v1.0"
  },
  "statements": [
    {
      "vulnerability": {
        "@id": "CVE-2023-1234",
        "name": "Cross-Site Scripting in Login Form"
      },
      "status": "not_affected",
      "justification": "Our application implements proper input sanitization"
    }
  ]
}
```

## Documentation

We generate two types of documents:

1. **VEX Document**: `docs/security/vex/YYYYMMDD-<product>-vex.json`
2. **Security Report**: `docs/security/YYYYMMDD-<title>-security-report.md`

For format details and examples, see the [complete documentation](.github/instructions/vex.instructions.md#reporting-and-documentation).

## Tools Included

This repository includes MCP (Model Context Protocol) servers that GitHub Copilot Agent interfaces with:

- **Trivy MCP Server**: Fast vulnerability scanner for code, dependencies, and containers
- **CVE-Search MCP**: Access to vulnerability intelligence
- **VEX Templates**: Ready-to-use templates for VEX document generation
- **Security Checklists**: Simplified guides for code review via GitHub Copilot

## Getting Started

### Prerequisites
Before using GitHub Copilot for security assessment:

1. Ensure you have GitHub Copilot Chat enabled in VS Code
2. Start the Trivy server:
   ```bash
   cd mcp_servers/trivy
   ./start-trivy-server.sh
   ```

### Sample Prompts for GitHub Copilot
Simply ask Copilot to conduct the security assessment:

```
Scan src/vulpy for vulnerabilities and generate a VEX document
```

Or be more specific:

```
Analyze the authentication system in src/vulpy/bad/mod_user.py for security issues
```

For a complete checklist and detailed instructions, refer to our [comprehensive guide](.github/instructions/vex.instructions.md#final-verification-checklist).
- [ ] Exploitability analysis conducted for all identified CVEs
- [ ] VEX statuses assigned based on thorough contextual analysis
- [ ] Severity levels assigned based on standardized criteria
- [ ] Remediation plans developed for all identified issues
- [ ] High and critical severity vulnerabilities addressed
- [ ] No new vulnerabilities introduced by remediation efforts
- [ ] VEX document generated in standardized format
- [ ] Security assessment report completed and stored appropriately


## Expected Output

The system will automatically generate detailed VEX documents that include:
- Standard-compliant vulnerability disclosures
- AI-powered exploitability assessments with justifications
- Context-aware recommendations based on actual code usage

## Benefits

- **Automated Intelligence**: Transforms raw vulnerability scans into actionable security intelligence
- **Reduced False Positives**: AI analysis focuses on actual risks in your specific context
- **Compliance Ready**: Generates industry-standard VEX documents for supply chain transparency
- **Contextual Analysis**: Understands how vulnerabilities apply to your specific codebase and deployment

## After cloning

```bash
git submodule init
git submodule update
```

## MCP Servers

```json
"mcp": {
    "servers": {
        "Trivy MCP": {
            "command": "trivy",
            "args": [
                "mcp"
            ]
        },
        "cve-search_mcp": {
            "command": "uv",
            "args": [
                "--directory",
                "mcp_servers/cve-search_mcp",
                "run",
                "main.py"
            ],
            "disabled": false,
            "autoApprove": []
        }
    }
}
```

## Issues
- https://github.com/microsoft/vscode/issues/243687#issuecomment-2734934398
- https://github.com/microsoft/vscode/issues/251308
- Run Trivy as SSE: `trivy mcp --transport sse --port 8080`

## Links
- https://github.com/aquasecurity/trivy-mcp
- https://github.com/roadwy/cve-search_mcp
- https://www.cve-search.org/api/
- https://github.com/marcoeg/mcp-nvd
- https://github.com/fportantier/vulpy