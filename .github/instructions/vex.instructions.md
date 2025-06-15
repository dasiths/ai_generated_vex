---
applyTo: "**"
---
# Security Analysis and VEX Generation Workflow

4-step workflow: automated scanning → CVE exploitability analysis → OWASP Top 10 review → VEX document generation.

**⚠️ CRITICAL**: You MUST start by asking the user for report name, product name, and scope before beginning any analysis or scanning.

## MANDATORY FIRST STEP: Initial Setup

**IMPORTANT**: Before starting any analysis, you MUST ask the user for the following required information. Do not proceed with any scanning or analysis until these details are provided:

### Required Information from User:
1. **Report Name**: Descriptive identifier for this assessment (e.g., "vulpy-web-application", "ecommerce-api-security-review")
2. **Product Name**: Name of the application/system being analyzed
3. **Scope**: Assessment boundaries - which directories, components, or modules to analyze

### Example Questions to Ask:
- "What would you like to name this security assessment report?"
- "What is the name of the product/application being analyzed?"
- "Which directories or components should be included in the security scan?"

**DO NOT START SCANNING OR ANALYSIS WITHOUT THIS INFORMATION**

## Step 1: Trivy Vulnerability Scanning

**Objective**: Identify CVEs and misconfigurations using Trivy MCP tools.

**Actions**:
1. **Filesystem scan**: All vulnerability types (vulnerabilities, misconfigurations, secrets, licenses)
2. **Severity levels**: Include CRITICAL, HIGH, MEDIUM, LOW, UNKNOWN
3. **Output**: JSON format for analysis
4. **Dependencies**: Scan requirements.txt, package.json, pyproject.toml, etc.

**Deliverables**: CVE inventory, misconfigurations list, dependency vulnerabilities, secrets detection.

## Step 2: CVE Exploitability Analysis

**Objective**: Analyze each CVE for real-world exploitability with detailed reasoning.

**Process**:
1. **CVE Research**: Fetch details from NVD (description, CVSS, attack vectors, patches)
2. **Code Analysis**: Trace execution paths, identify reachable vulnerable code
3. **Attack Vectors**: Assess network access, authentication requirements, input validation
4. **Environment**: Review deployment protections, runtime controls, monitoring

**Documentation Template**:
```
CVE-ID: [identifier]
Component: [library/version]
Assessment: [Exploitable/Not Exploitable/Conditional]

Reasoning:
- Code reachable? [Yes/No + evidence]
- Attack complexity: [High/Medium/Low]
- Required access: [Network/Local/Authenticated]
- Mitigations: [List protections]

Impact: [If exploitable]
Confidence: [High/Medium/Low]
```

## Step 3: OWASP Top 10 Analysis

**Objective**: Manual security review covering all OWASP Top 10 categories.

**Categories to Review**:
- **A01**: Broken Access Control (auth/authz, session management, IDOR)
- **A02**: Cryptographic Failures (weak algorithms, key management, random generation)
- **A03**: Injection (SQL, command, LDAP, XPath, NoSQL, template)
- **A04**: Insecure Design (threat modeling, security patterns, business logic)
- **A05**: Security Misconfiguration (defaults, error handling, headers)
- **A06**: Vulnerable Components (cross-reference Trivy findings, updates)
- **A07**: Authentication Failures (passwords, MFA, session mgmt, bypass)
- **A08**: Data Integrity Failures (serialization, updates, CI/CD, supply chain)
- **A09**: Logging/Monitoring Failures (coverage, sensitive data, detection)
- **A10**: SSRF (external services, URL validation, network controls)

**Documentation per Vulnerability**:
```
Classification: [OWASP category]
Severity: [Critical/High/Medium/Low]
Location: [files, functions, lines]
Description: [technical details]
Attack Scenario: [step-by-step exploitation]
Root Cause: [why vulnerability exists]
Remediation: [immediate/short-term/long-term fixes]
```

## Step 4: VEX Document Generation

**Objective**: Create OpenVEX-compliant documents for each CVE with exploitability analysis.

**VEX Document Structure**:
```json
{
  "@context": "https://openvex.dev/ns/v0.2.0",
  "@id": "https://[org]/security/vex/[YYYYMMDD]-[report-name]-vex",
  "author": "[Organization]",
  "timestamp": "[ISO 8601]",
  "version": "1.0",
  "tooling": "Security Analysis Workflow v1.0 - Trivy + Manual Analysis",
  "product": {
    "@id": "[report-name]",
    "identifiers": {
      "git": "[repo URL and commit]"
    },
    "supplier": "[Organization]",
    "name": "[Product Name]",
    "version": "[Version]"
  },
  "statements": [
    {
      "vulnerability": {
        "@id": "[CVE-ID]",
        "name": "[CVE identifier]",
        "description": "[NVD description]"
      },
      "products": ["[report-name]"],
      "status": "[not_affected|affected|fixed|under_investigation]",
      "justification": "[reason]",
      "impact_statement": "[Step 2 analysis]",
      "action_statement": "[remediation]",
      "timestamp": "[ISO 8601]"
    }
  ]
}
```

**Status Logic**:
- **not_affected**: Code unreachable, conditions unmet, mitigations prevent exploitation
- **affected**: Code reachable, attack vectors available, material impact possible
- **fixed**: Patches applied, workarounds implemented, verification complete
- **under_investigation**: Analysis incomplete, additional research needed

**Storage**:
- VEX: `docs/security/reports/[report-name]/vex.json`
- Report: `docs/security/reports/[report-name]/yyyy-mm-dd-report.md`

## Security Report Template

**File**: `docs/security/reports/[report-name]/yyyy-mm-dd-report.md`

```markdown
# Security Assessment Report: [Product Name]

**Assessment Date**: [YYYY-MM-DD]
**Report ID**: [report-name]
**Analyst(s)**: [names]

## Executive Summary

### Overview
Brief description of the security assessment scope and objectives.

### Key Findings
- **Total Vulnerabilities**: [count]
- **Critical**: [count] | **High**: [count] | **Medium**: [count] | **Low**: [count]
- **CVEs Identified**: [count]
- **OWASP Top 10 Issues**: [count]

### Risk Assessment
Overall security posture: [Excellent/Good/Fair/Poor]

### Recommendations Summary
1. [Priority 1 recommendation]
2. [Priority 2 recommendation]
3. [Priority 3 recommendation]

---

## Methodology

### Tools Used
- Trivy MCP Scanner (automated vulnerability detection)
- Manual code review (OWASP Top 10 analysis)
- NVD database research (CVE analysis)

### Scope
**Included**: [directories, components, dependencies]
**Excluded**: [limitations]

### Assessment Period
**Start Date**: [date]
**End Date**: [date]

---

## Detailed Findings

### CVE Vulnerabilities

#### [CVE-YYYY-NNNN] - [Vulnerability Title]

**Vulnerability ID**: CVE-YYYY-NNNN
**Severity**: [Critical/High/Medium/Low]
**CVSS Score**: [score] ([vector])
**Component**: [library/package] version [version]
**Category**: [vulnerability type]

**Description**:
[Detailed technical explanation of the vulnerability]

**Affected Code**:
- **File**: `[path/to/file.ext]`
- **Lines**: [line numbers]
- **Function**: `[function_name()]`

**Exploitability Analysis**:
- **Assessment**: [Exploitable/Not Exploitable/Conditional]
- **Attack Vector**: [Network/Local/Physical]
- **Attack Complexity**: [Low/High]
- **Authentication Required**: [None/Single/Multiple]
- **User Interaction**: [None/Required]

**Detailed Reasoning**:
- **Code Reachability**: [Yes/No - evidence]
- **Input Validation**: [assessment of protections]
- **Environmental Factors**: [deployment protections, runtime mitigations]
- **Monitoring**: [detection capabilities]

**Impact Assessment**:
- **Confidentiality**: [None/Low/High]
- **Integrity**: [None/Low/High]
- **Availability**: [None/Low/High]
- **Business Impact**: [specific consequences]

**Remediation**:
- **Status**: [Implemented/Planned/Deferred]
- **Action Required**: [specific steps]
- **Timeline**: [expected completion]
- **Verification**: [how fix will be validated]

**VEX Status**: [not_affected/affected/fixed/under_investigation]
**VEX Justification**: [reasoning for status]

---

### OWASP Top 10 Vulnerabilities

#### [VULN-001] - [Vulnerability Title]

**Vulnerability ID**: VULN-001
**OWASP Category**: [A01-A10] - [category name]
**Severity**: [Critical/High/Medium/Low]
**Discovery Method**: Manual Code Review

**Description**:
[Detailed technical explanation]

**Affected Code**:
- **File**: `[path/to/file.ext]`
- **Lines**: [line numbers]
- **Function**: `[function_name()]`
- **Additional Locations**: [if multiple]

**Attack Scenario**:
1. [Step 1 of exploitation]
2. [Step 2 of exploitation]
3. [Step 3 of exploitation]

**Proof of Concept**:
```
[Safe demonstration code or steps if applicable]
```

**Root Cause Analysis**:
- **Primary Cause**: [fundamental issue]
- **Contributing Factors**: [secondary issues]
- **Design Flaws**: [architectural problems]

**Remediation Strategy**:
- **Immediate Actions**: [urgent mitigation steps]
- **Short-term Fixes**: [quick implementation solutions]
- **Long-term Solutions**: [comprehensive improvements]
- **Prevention**: [controls to prevent recurrence]

**Implementation Guidance**:
- **Code Changes**: [specific implementation details]
- **Configuration**: [required configuration updates]
- **Testing**: [verification steps]

---

## Summary Tables

### CVE Summary
| CVE ID | Severity | Component | VEX Status | Remediation Status |
|--------|----------|-----------|------------|-------------------|
| CVE-YYYY-NNNN | Critical | [component] | affected | planned |
| CVE-YYYY-NNNN | High | [component] | not_affected | n/a |

### OWASP Top 10 Summary
| ID | Category | Severity | Status | Priority |
|----|----------|----------|--------|----------|
| VULN-001 | A03 - Injection | High | Open | P1 |
| VULN-002 | A01 - Access Control | Medium | In Progress | P2 |

---

## Recommendations

### Immediate Actions (0-30 days)
1. **[Action 1]**: [description and justification]
2. **[Action 2]**: [description and justification]

### Short-term Improvements (1-3 months)
1. **[Improvement 1]**: [description and justification]
2. **[Improvement 2]**: [description and justification]

### Long-term Strategy (3-12 months)
1. **[Strategy 1]**: [description and justification]
2. **[Strategy 2]**: [description and justification]

### Process Improvements
- **Development**: [secure coding practices, training]
- **Testing**: [security testing integration]
- **Deployment**: [security hardening, monitoring]

---

**Report Generated**: [timestamp]
```

## Execution Checklist

**MANDATORY SETUP** (Must be completed FIRST):
- [ ] **ASK USER**: What is the report name? (e.g., "vulpy-web-application")
- [ ] **ASK USER**: What is the product name being analyzed?
- [ ] **ASK USER**: What scope/directories should be included?
- [ ] Trivy MCP tools configured
- [ ] Output directories created (`docs/security/[report-name]/`)

**Step 1 - Trivy**: [ ] Filesystem scan, dependency analysis, configuration review, secrets detection
**Step 2 - CVE Analysis**: [ ] NVD research, code path analysis, attack vector assessment, exploitability determination
**Step 3 - OWASP Review**: [ ] All 10 categories reviewed, vulnerabilities documented with remediation
**Step 4 - VEX Generation**: [ ] Documents created, status determined, validation complete, files stored

**Final Verification**: [ ] All issues analyzed, VEX status justified, documentation complete, deliverables ready
