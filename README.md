# AI-Powered Security Scanning with VEX Generation

## What is VEX and Why It Matters

**VEX (Vulnerability Exploitability eXchange)** is a standardized format for communicating the actual security impact of vulnerabilities in specific products or deployments. Unlike traditional vulnerability lists that simply enumerate CVEs, VEX documents provide contextual analysis of whether vulnerabilities are actually exploitable in your environment.

**Key VEX Statuses:**
- **Not Affected**: The vulnerable code exists but isn't reachable or used
- **Affected**: The vulnerability can be exploited in this specific context
- **Fixed**: A patch has been applied
- **Under Investigation**: Status requires further analysis

**Why VEX is Critical:**
- **Reduces Alert Fatigue**: Distinguishes between theoretical and actual risks
- **Supply Chain Transparency**: Enables informed decisions about third-party components  
- **Regulatory Compliance**: Emerging requirements mandate VEX for government and enterprise software
- **Contextual Intelligence**: Shows *why* a vulnerability does or doesn't matter in your specific case

Traditional vulnerability scanning tells you "CVE-X exists in package Y." VEX tells you "CVE-X exists but cannot be exploited because we don't use the vulnerable function and have network controls that prevent the attack."

## Overview

We will implement an automated security scanning system using GitHub Copilot as an intelligent agent orchestrating two MCP (Model Context Protocol) servers to generate comprehensive VEX documents with contextual vulnerability analysis.

## Architecture

**GitHub Copilot Agent** + **Trivy MCP Server** + **CVE Database MCP Server** → **VEX Document**

- **Trivy MCP Server**: Scans codebases for vulnerabilities in dependencies, containers, and infrastructure
- **CVE Database MCP Server**: Provides detailed vulnerability intelligence and exploitability data
- **GitHub Copilot Agent**: Analyzes scan results in code context and generates intelligent VEX documents

## Workflow

### 1. Initial Scan
**Agent Action**: Trigger vulnerability scan
```
Scan the current repository using Trivy to identify all vulnerabilities in dependencies, container images, and infrastructure as code files. Focus on HIGH and CRITICAL severity findings.
```

### 2. Vulnerability Analysis
**Agent Action**: For each vulnerability found, query CVE database
```
For CVE-2023-45857 found in axios@0.21.1:
- Get detailed CVE information including CVSS score, attack vectors, and known exploits
- Check if there are any proof-of-concept exploits available
- Retrieve vendor advisories and patch information
```

### 3. Code Context Analysis  
**Agent Action**: Analyze how vulnerabilities apply to the specific codebase
```
Analyze the codebase to determine if CVE-2023-45857 affects our application:
- Find all usage of axios redirect functionality
- Check if user input can control redirect URLs
- Examine network configurations and egress restrictions
- Determine if vulnerable code paths are reachable
- Provide confidence score for exploitability assessment
```

### 4. VEX Status Determination
**Agent Action**: Classify vulnerability status with justification
```
Based on code analysis, classify CVE-2023-45857 status:
- not_affected: If vulnerable code isn't used or reachable
- affected: If vulnerability can be exploited in our context  
- under_investigation: If analysis is inconclusive
- fixed: If patched version is already deployed

Provide detailed justification for the classification including:
- Specific code paths analyzed
- Security controls that mitigate risk
- Recommended actions (update, monitor, or ignore)
```

### 5. VEX Document Generation
**Agent Action**: Generate compliant VEX document
```
Generate a complete VEX document including:
- Product identification and metadata
- All vulnerability findings with detailed analysis
- Justifications for each vulnerability status
- Agent confidence scores and analysis metadata
- Recommendations for remediation or monitoring
```

## Sample Agent Prompts

### Comprehensive Analysis Prompt
```
You are a security analysis agent. Using the Trivy MCP server, scan this repository for vulnerabilities. For each HIGH or CRITICAL finding:

1. Use the CVE Database MCP server to get detailed vulnerability information
2. Analyze the codebase to determine actual exploitability 
3. Consider our deployment environment and security controls
4. Classify the vulnerability status (affected/not_affected/under_investigation)
5. Provide confidence scores and detailed justifications

Generate a complete VEX document with your analysis.
```

### Code-Specific Analysis Prompt  
```
I found CVE-2023-26136 in tough-cookie@4.0.0. This is a prototype pollution vulnerability.

Analyze our codebase to determine:
- Where and how tough-cookie is used
- What user input flows into cookie parsing functions  
- Whether prototype pollution could be triggered
- What security controls might prevent exploitation
- Recommended remediation actions

Provide your analysis with confidence score.
```

## Expected Output

The system will automatically generate detailed VEX documents that include:
- Standard-compliant vulnerability disclosures
- AI-powered exploitability assessments with justifications
- Context-aware recommendations based on actual code usage
- Confidence scores for each analysis decision
- Comprehensive metadata for audit and compliance purposes

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
- Run Trivy as SSE: `trivy mcp --transport sse --port 8080`

## Links
- https://github.com/aquasecurity/trivy-mcp
- https://github.com/roadwy/cve-search_mcp
- https://www.cve-search.org/api/
- https://github.com/marcoeg/mcp-nvd
- https://github.com/fportantier/vulpy