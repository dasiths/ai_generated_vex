---
applyTo: "**"
---
# Security Analysis and VEX Generation Workflow

4-step workflow: automated scanning → **CRITICAL CVE exploitability analysis** → OWASP Top 10 review → VEX document generation.

**⚠️ CRITICAL**: You MUST start by asking the user for report name, product name, and scope before beginning any analysis or scanning.

## CORE PRINCIPLE: CVE Exploitability Analysis is PARAMOUNT

**THE MOST IMPORTANT ASPECT** of this entire workflow is determining whether each CVE is actually exploitable in the specific context of the application being analyzed. This is not a checkbox exercise - it requires deep technical analysis to provide accurate VEX statements that security teams can trust for risk-based decision making.

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

**⚠️ THIS IS THE MOST CRITICAL STEP ⚠️**

**Objective**: Conduct rigorous, context-specific analysis of each CVE to determine real-world exploitability. This is not about checking if a vulnerable library exists - it's about proving whether an attacker can actually exploit the vulnerability in the current application context.

**MANDATORY DEPTH OF ANALYSIS**:
This step requires the highest level of technical rigor. Each CVE must be analyzed with the thoroughness of a penetration test finding. Surface-level analysis is unacceptable and undermines the entire VEX document's credibility.

**Process**:
1. **CVE Research**: Fetch comprehensive details from NVD, security advisories, and exploit databases
   - **NVD Lookup**: Use https://nvd.nist.gov/vuln/detail/{CVE-ID} to retrieve official CVE details
   - Vulnerability mechanism and root cause
   - Attack prerequisites and conditions
   - Known exploit techniques and proof-of-concepts
   - Environmental dependencies for successful exploitation

2. **Deep Code Analysis**: Trace complete execution paths from entry points to vulnerable code
   - **Entry Point Analysis**: How can external input reach the vulnerable component?
   - **Control Flow Tracing**: Map all possible paths that could trigger the vulnerability
   - **Data Flow Analysis**: Track how untrusted input flows through the application
   - **Reachability Proof**: Demonstrate concrete evidence that vulnerable code can be reached

3. **Attack Vector Assessment**: Evaluate realistic attack scenarios
   - **Network Access**: Can the vulnerability be triggered remotely?
   - **Authentication Barriers**: What level of access is required?
   - **Input Validation**: Are there filters, sanitizers, or validators that prevent exploitation?
   - **Runtime Protections**: Do WAFs, sandboxes, or other controls block attacks?

4. **Environmental Context**: Review deployment and operational protections
   - **Infrastructure Controls**: Load balancers, firewalls, network segmentation
   - **Runtime Security**: ASLR, DEP, stack canaries, sandboxing
   - **Monitoring & Detection**: Can exploitation attempts be detected and blocked?
   - **Patch Status**: Are security updates available and applicable?

**EVIDENCE REQUIREMENTS**:
Every exploitability determination MUST be backed by concrete evidence:
- **Code snippets** showing vulnerable patterns or protective measures
- **Configuration examples** demonstrating security controls
- **Network diagrams** illustrating access restrictions
- **Execution paths** that prove reachability of vulnerable code
- **Attack scenarios** that detail how an exploit could be executed

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

**Objective**: Comprehensive manual security review to identify critical vulnerabilities that exist beyond known CVEs. While Step 2 focuses on validating CVE exploitability, this step discovers application-specific security flaws that don't have CVE identifiers but may pose equal or greater risk.

**STRATEGIC PURPOSE**:
The OWASP Top 10 analysis serves a fundamentally different purpose than CVE analysis:

- **CVE Analysis**: Validates whether known, catalogued vulnerabilities are exploitable
- **OWASP Analysis**: Discovers unknown, application-specific vulnerabilities through systematic security review

**WHY OWASP TOP 10 IS ESSENTIAL**:
1. **Coverage Gaps**: CVE databases don't capture business logic flaws, design vulnerabilities, or implementation-specific issues
2. **Custom Code Risks**: Application-specific vulnerabilities often pose higher risk than dependency CVEs
3. **Context-Specific Issues**: Security flaws that only manifest in particular deployment or usage contexts
4. **Emerging Threats**: New attack patterns not yet catalogued in CVE databases
5. **Configuration Vulnerabilities**: Deployment and configuration issues that create exploitable conditions

**COMPREHENSIVE REVIEW APPROACH**:
Each OWASP category must be analyzed with the same rigor as CVE exploitability analysis. This is not a compliance checklist - it's active threat hunting within the application.

**Categories to Review**:
- **A01**: Broken Access Control (auth/authz, session management, IDOR, privilege escalation)
- **A02**: Cryptographic Failures (weak algorithms, key management, random generation, data protection)
- **A03**: Injection (SQL, command, LDAP, XPath, NoSQL, template, code injection)
- **A04**: Insecure Design (threat modeling, security patterns, business logic flaws)
- **A05**: Security Misconfiguration (defaults, error handling, headers, hardening)
- **A06**: Vulnerable Components (cross-reference with Trivy findings, update policies)
- **A07**: Authentication Failures (passwords, MFA, session mgmt, bypass techniques)
- **A08**: Data Integrity Failures (serialization, updates, CI/CD security, supply chain)
- **A09**: Logging/Monitoring Failures (coverage, sensitive data exposure, detection gaps)
- **A10**: SSRF (external services, URL validation, network controls, cloud metadata access)

**CRITICAL FOCUS AREAS**:
- **Business Logic Vulnerabilities**: Flaws in application workflow that can be abused
- **Authorization Bypass**: Ways to access functionality or data without proper permissions
- **Data Exposure**: Sensitive information disclosure through various attack vectors
- **Configuration Weaknesses**: Deployment settings that create attack opportunities
- **Custom Implementation Flaws**: Security issues in application-specific code

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

## Step 4: Documentation Generation

**Objective**: Create three comprehensive deliverables that provide complete security assessment documentation.

### THREE REQUIRED DELIVERABLES:

1. **Summary.md** - Executive-level overview for management and stakeholders
2. **Security Report** - Detailed technical analysis with all findings and remediation guidance  
3. **VEX Document** - OpenVEX-compliant JSON file with CVE exploitability determinations

**Storage Structure**:
All three files must be stored in: `docs/security/reports/[report-name]/`

- **Summary**: `docs/security/reports/[report-name]/summary.md`
- **Report**: `docs/security/reports/[report-name]/yyyy-mm-dd-report.md`
- **VEX**: `docs/security/reports/[report-name]/vex.json`

### 1. Summary Document (summary.md)

**Purpose**: Technical summary for security experts who need quick overview of findings and immediate concerns.

**Template**:
```markdown
# Security Assessment Summary: [Product Name]

**Assessment Date**: [YYYY-MM-DD]
**Report ID**: [report-name]
**Scope**: [directories/components analyzed]

## Assessment Overview
[Brief description of what was scanned and analyzed]

## Key Findings Summary
- **Total Vulnerabilities Found**: [count]
- **Critical**: [count] | **High**: [count] | **Medium**: [count] | **Low**: [count]
- **CVEs Analyzed**: [count] ([exploitable-count] exploitable, [not-exploitable-count] not exploitable)
- **OWASP Top 10 Issues**: [count]

## Critical Issues Requiring Immediate Attention
1. **[Critical Issue 1]** - [location/component]
2. **[Critical Issue 2]** - [location/component]
3. **[Critical Issue 3]** - [location/component]

## Vulnerability Breakdown
| Category | Critical | High | Medium | Low | Total |
|----------|----------|------|--------|-----|-------|
| CVE Vulnerabilities | [count] | [count] | [count] | [count] | [count] |
| OWASP Top 10 Issues | [count] | [count] | [count] | [count] | [count] |
| **TOTALS** | **[count]** | **[count]** | **[count]** | **[count]** | **[count]** |

## CVE Exploitability Summary
| CVE ID | Severity | Component | Exploitable | VEX Status |
|--------|----------|-----------|-------------|------------|
| CVE-YYYY-NNNN | Critical | [component] | Yes/No | affected/not_affected |

## Key Technical Concerns
- **Authentication/Authorization**: [findings summary]
- **Input Validation**: [findings summary]  
- **Cryptography**: [findings summary]
- **Configuration**: [findings summary]

**Full Technical Analysis**: See `yyyy-mm-dd-report.md`
**VEX Document**: See `vex.json` for detailed CVE determinations
```

### 2. VEX Document Structure (vex.json):
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

### 3. Security Report Template (yyyy-mm-dd-report.md)

**File**: `docs/security/reports/[report-name]/yyyy-mm-dd-report.md`

```markdown
# Security Assessment Report: [Product Name]

**Assessment Date**: [YYYY-MM-DD]
**Report ID**: [report-name]
**Analyst(s)**: [names]

## Executive Summary

### Assessment Scope
Brief description of what was analyzed and the methodology used.

### Critical Findings
- **Total Vulnerabilities**: [count]
- **Critical**: [count] | **High**: [count] | **Medium**: [count] | **Low**: [count]
- **CVEs Identified**: [count] ([exploitable-count] exploitable)
- **OWASP Top 10 Issues**: [count]

### Immediate Security Concerns
1. [Most critical vulnerability requiring immediate attention]
2. [Second most critical issue]
3. [Third most critical issue]

---

## Methodology

### Tools Used
- Trivy MCP Scanner (automated vulnerability detection)
- Manual code review (OWASP Top 10 analysis)
- NVD database research (CVE analysis)

### Scope
**Included**: [directories, components, dependencies analyzed]
**Excluded**: [any limitations or areas not covered]

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
- **Technical Impact**: [specific technical consequences]

**Remediation**:
- **Required Action**: [specific technical steps needed]
- **Verification**: [how to validate the fix]
- **References**: [relevant security advisories, patches]

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
- **Immediate Actions**: [urgent technical fixes]
- **Code Changes**: [specific implementation requirements]
- **Configuration Updates**: [security hardening needed]
- **Testing Verification**: [how to validate fixes]

**Technical Implementation**:
- **File Modifications**: [specific files that need changes]
- **Function Updates**: [functions requiring security improvements]
- **Security Controls**: [additional protections needed]

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

## Technical Recommendations

### Critical Fixes Required
1. **[Critical Fix 1]**: [technical details and implementation]
2. **[Critical Fix 2]**: [technical details and implementation]

### Security Improvements Needed
1. **[Improvement 1]**: [technical implementation details]
2. **[Improvement 2]**: [technical implementation details]

### Security Controls to Implement
- **Input Validation**: [specific validation requirements]
- **Authentication**: [authentication improvements needed]
- **Authorization**: [access control enhancements]
- **Configuration**: [security hardening steps]

---

**Report Generated**: [timestamp]
```

**Execution Checklist

**MANDATORY SETUP** (Must be completed FIRST):
- [ ] **ASK USER**: What is the report name? (e.g., "vulpy-web-application")
- [ ] **ASK USER**: What is the product name being analyzed?
- [ ] **ASK USER**: What scope/directories should be included?
- [ ] Trivy MCP tools configured
- [ ] Output directories created (`docs/security/[report-name]/`)

**Step 1 - Trivy**: [ ] Filesystem scan, dependency analysis, configuration review, secrets detection

**Step 2 - CVE Analysis** (CRITICAL - MOST IMPORTANT):
- [ ] NVD research with comprehensive vulnerability details
- [ ] **DEEP CODE ANALYSIS**: Complete execution path tracing from entry points to vulnerable code
- [ ] **REACHABILITY PROOF**: Concrete evidence that vulnerable code can be reached by attackers
- [ ] **ATTACK VECTOR VALIDATION**: Realistic assessment of exploitation prerequisites
- [ ] **ENVIRONMENTAL CONTEXT**: Full review of protective controls and mitigations
- [ ] **EVIDENCE COLLECTION**: Code snippets, configurations, and technical proof for each determination
- [ ] Exploitability determination with detailed technical justification

**Step 3 - OWASP Review**: 
- [ ] **BEYOND CVE ANALYSIS**: Focus on discovering application-specific vulnerabilities
- [ ] All 10 categories systematically reviewed for custom implementation flaws
- [ ] Business logic vulnerabilities identified and documented
- [ ] Configuration and deployment security issues assessed
- [ ] Non-CVE vulnerabilities documented with same rigor as CVE analysis

**Step 4 - Documentation Generation**: 
- [ ] **SUMMARY.MD**: Technical summary created focusing on security findings and immediate concerns
- [ ] **SECURITY REPORT**: Detailed technical report with complete vulnerability analysis and remediation steps
- [ ] **VEX DOCUMENT**: OpenVEX-compliant JSON with CVE exploitability determinations
- [ ] All three documents stored in `docs/security/reports/[report-name]/` directory

**Final Verification**: 
- [ ] **CVE EXPLOITABILITY**: Every CVE determination backed by concrete technical evidence
- [ ] **OWASP COVERAGE**: Comprehensive review beyond known CVEs completed
- [ ] **THREE DELIVERABLES**: Summary.md, detailed report, and VEX.json all completed
- [ ] All VEX status justified with detailed technical reasoning
- [ ] Documentation demonstrates depth of analysis performed
- [ ] All files stored in correct directory structure: `docs/security/reports/[report-name]/`
- [ ] Deliverables ready for security team decision-making
