---
mode: agent
model: Claude Sonnet 4.5
description: Security analysis and VEX generation workflow
tools: ['edit/createFile', 'edit/createDirectory', 'edit/editFiles', 'search', 'trivy-mcp/*', 'vexdoc-mcp/*', 'osv-mcp/*', 'executePrompt', 'usages', 'think', 'changes', 'fetch', 'githubRepo', 'todos']
---

# Security Analysis and VEX Generation Workflow

3-step workflow: automated scanning → **CRITICAL CVE exploitability analysis** → VEX document generation.

**⚠️ CRITICAL**: You MUST start by asking the user for report name, product name, and scope before beginning any analysis or scanning.

## CORE PRINCIPLE: CVE Exploitability Analysis is PARAMOUNT

**THE MOST IMPORTANT ASPECT** of this entire workflow is determining whether each CVE is actually exploitable in the specific context of the application being analyzed. This is not a checkbox exercise - it requires deep technical analysis to provide accurate VEX statements that security teams can trust for risk-based decision making.

## MANDATORY FIRST STEP: Initial Setup

**IMPORTANT**: Before starting any analysis, you MUST ask the user for the following required information. Do not proceed with any scanning or analysis until these details are provided:

### Required Information from User:
1. **Report Name**: Descriptive identifier for this assessment (e.g., "vulpy-web-application", "ecommerce-api-security-review")
2. **Product Name**: Name of the application/system being analyzed
3. **Scope**: Assessment boundaries - which directories, components, or modules to analyze

### Required MCP Tools:

**IMPORTANT**: If these MCP tools are not already configured, you must ask the user set them up before proceeding:

- **Trivy MCP**: For vulnerability scanning and dependency analysis. 'scan_filesystem', 'scan_image', 'scan_repository'.
- **vexdoc-mcp**: For generating VEX documents
- **osv-mcp**: For detailed CVE analysis and exploitability research

### Example Questions to Ask:
- "What would you like to name this security assessment report?"
- "What is the name of the product/application being analyzed?"
- "Which directories or components should be included in the security scan?"

**DO NOT START SCANNING OR ANALYSIS WITHOUT THIS INFORMATION**

## PROGRESSIVE DOCUMENTATION REQUIREMENT

**⚠️ MANDATORY: Write reports as you progress through each step**

Instead of waiting until the end, you MUST create and update documentation files after completing each major step. This ensures progress is captured even if the analysis is interrupted and provides stakeholders with incremental updates.

### Required Progressive Actions:
1. **After Step 1 (Trivy Scan)**: Create initial summary.md with scan results and create the detailed report with Trivy findings
2. **After Step 2 (CVE Analysis)**: Update both summary.md and detailed report with CVE exploitability analysis
4. **After Step 3 (Final Documentation)**: Finalize all three deliverables with complete analysis

### Directory Structure Setup:
Before starting any analysis, create the report directory structure:
```
docs/security/reports/[report-name]/
├── summary.md
├── yyyy-mm-dd-report.md  
└── vex.json
```

**Benefits of Progressive Documentation**:
- Captures analysis progress incrementally
- Provides stakeholders with interim results  
- Prevents loss of work if analysis is interrupted
- Enables early review and feedback on findings
- Demonstrates systematic methodology

## Step 1: Trivy Vulnerability Scanning

**Objective**: Identify CVEs and misconfigurations using Trivy MCP tools. 'scan_filesystem', 'scan_image', 'scan_repository'

**Actions**:
1. **Filesystem scan**: All vulnerability types (vulnerabilities, misconfigurations, secrets, licenses)
2. **Severity levels**: Include CRITICAL, HIGH, MEDIUM, LOW, UNKNOWN
3. **Output**: JSON format for analysis
4. **Dependencies**: Scan requirements.txt, package.json, pyproject.toml, etc.

**Deliverables**: CVE inventory, misconfigurations list, dependency vulnerabilities, secrets detection.

**PROGRESSIVE DOCUMENTATION ACTION**: 
After completing Trivy scanning:
1. **Create** `docs/security/reports/[report-name]/summary.md` with initial scan results summary
2. **Create** `docs/security/reports/[report-name]/yyyy-mm-dd-report.md` with detailed Trivy findings
3. Include CVE count, severity breakdown, and initial findings in both documents
4. This provides stakeholders with immediate scan results before deeper analysis begins

## Step 2: CVE Exploitability Analysis

**⚠️ THIS IS THE MOST CRITICAL STEP ⚠️**

**Objective**: Conduct rigorous, context-specific analysis of each CVE to determine real-world exploitability. This is not about checking if a vulnerable library exists - it's about proving whether an attacker can actually exploit the vulnerability in the current application context.

**MANDATORY DEPTH OF ANALYSIS**:
This step requires the highest level of technical rigor. Each CVE must be analyzed with the thoroughness of a penetration test finding. Surface-level analysis is unacceptable and undermines the entire VEX document's credibility. Make use of your think tool

**Process**:
1. **CVE Research**: Fetch comprehensive details from OSV, security advisories, and exploit databases
   - **OSV Lookup**: For each CVE-ID identified in Step 1, use the osv-mcp tool to retrieve detailed vulnerability information
   - **Analysis Requirements**:
     - Vulnerability mechanism and root cause
     - Attack prerequisites and conditions
     - Known exploit techniques and proof-of-concepts
     - Environmental dependencies for successful exploitation
  **Tool Usage**:
  - For each CVE-ID from trivy-mcp results: call osv-mcp tool
  - Compile comprehensive vulnerability profiles from OSV data

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

**PROGRESSIVE DOCUMENTATION ACTION**:
After completing CVE exploitability analysis:
1. **Update** `summary.md` with CVE exploitability summary table and critical findings
2. **Update** `yyyy-mm-dd-report.md` with detailed CVE analysis section for each vulnerability
3. Include exploitability determinations, technical reasoning, and VEX status for each CVE
4. This provides security teams with critical CVE analysis before OWASP review begins

## Step 3: Documentation Generation

**Objective**: Finalize and polish the three comprehensive deliverables that have been progressively created throughout the analysis.

**IMPORTANT**: By this step, all three documents should already exist with substantial content from previous steps. This step focuses on final review, completeness verification, and quality assurance rather than creating documents from scratch.

### FINAL REVIEW AND COMPLETION TASKS:

1. **Summary.md Review**:
   - Verify executive summary accurately reflects all findings
   - Ensure vulnerability counts and severity breakdowns are accurate
   - Confirm critical issues section highlights most important findings
   - Validate that technical concerns summary covers all major areas

2. **Security Report Finalization**:
   - Complete any missing CVE analysis details
   - Finalize OWASP Top 10 section with all discovered vulnerabilities
   - Ensure remediation strategies are complete and actionable
   - Verify all summary tables are accurate and complete
   - Add final technical recommendations section

3. **VEX Document Completion**:
   - Validate all CVE statements are technically accurate
   - Ensure VEX status justifications align with exploitability analysis
   - Verify product identifiers and vulnerability IDs are correct
   - Confirm document follows OpenVEX specification

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

## Critical Issues Requiring Immediate Attention
1. **[Critical Issue 1]** - [location/component]
2. **[Critical Issue 2]** - [location/component]
3. **[Critical Issue 3]** - [location/component]

## Vulnerability Breakdown
| Category | Critical | High | Medium | Low | Total |
|----------|----------|------|--------|-----|-------|
| CVE Vulnerabilities | [count] | [count] | [count] | [count] | [count] |
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

### 2. VEX Document Generation

**Objective**: Create individual VEX statements for each CVE-product combination and merge into comprehensive vex.json

### Process:

#### 1. Individual VEX Statement Creation
For each CVE found in Step 1 with analysis from Step 2:

- **Tool**: Use vexdoc-mcp with `create_vex_statement` function
- **Required inputs**:
  - `product`: PURL format identifier from trivy scan (e.g., "pkg:apk/wolfi/git@2.39.0-r1?arch=x86_64")
  - `vulnerability`: CVE-ID from Step 1 (e.g., "CVE-2023-1234")
  - `status`: Determined from Step 2 analysis (not_affected|affected|fixed|under_investigation)
- **Optional inputs** (based on Step 2 analysis):
  - `justification`: Required if status is "not_affected"
  - `impact_statement`: impact statement should only be set when not using status "affected"
  - `action_statement`: Remediation recommendations
  - `author`: Organization/team name

Save the statement in `docs/security/reports/[report-name]/vex-working/[CVE-ID].json`

#### 2. VEX Document Consolidation
- **Tool**: Use vexdoc-mcp with `merge_vex_documents` function
- **Input**: Each vex statement saved in `docs/security/reports/[report-name]/vex-working/*.json` folder
- **Output**: Single comprehensive vex.json document

### Tool Usage Workflow:
1. For each (CVE-ID + vulnerable_library) pair from trivy-mcp:
   - Call `vexdoc-mcp.create_vex_statement` with product PURL, CVE-ID, status, and analysis findings
   - **⚠️ CRITICAL**: Don't use special characters in the impact_statement or action_statement fields
   - Collect all individual VEX statements
2. Call `vexdoc-mcp.merge_vex_documents` with array of all statements
3. Output: Final consolidated vex.json document
4. Remove the ` docs/security/reports/[report-name]/vex-working` folder.

### Deliverables:
- Individual VEX statements per CVE-product pair
- Consolidated vex.json document

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
- [ ] Output directories created (`docs/security/reports/[report-name]/`)

**Step 1 - Trivy Scanning & Initial Documentation**:
- [ ] Filesystem scan, dependency analysis, configuration review, secrets detection
- [ ] **CREATE** `summary.md` with initial scan results and vulnerability counts
- [ ] **CREATE** `yyyy-mm-dd-report.md` with detailed Trivy findings section
- [ ] Provide stakeholders with immediate scan results summary

**Step 2 - CVE Analysis & Documentation Update** (CRITICAL - MOST IMPORTANT):

### Dynamic CVE Task Management:
1. **After Step 1 Trivy scan**, extract all CVE-IDs from scan results
2. **Add individual CVE analysis tasks** to the todo list using `manage_todo_list` tool
3. **For each CVE-ID discovered**, create a dedicated task: "Analyze [CVE-ID] exploitability"
4. **Work through each CVE task systematically**, marking as in-progress → completed

### For Each Identified CVE (repeat this process for every CVE found):

**IMPORTANT**: Before analyzing each CVE, mark the corresponding CVE task as "in-progress" in the todo list.

#### CVE-[YYYY-NNNNN] Analysis Process:
- [ ] **Mark CVE task as in-progress** in todo list
- [ ] NVD research with comprehensive vulnerability details using osv-mcp
- [ ] **DEEP CODE ANALYSIS**: Complete execution path tracing from entry points to vulnerable code
- [ ] **REACHABILITY PROOF**: Concrete evidence that vulnerable code can be reached by attackers
- [ ] **ATTACK VECTOR VALIDATION**: Realistic assessment of exploitation prerequisites
- [ ] **ENVIRONMENTAL CONTEXT**: Full review of protective controls and mitigations
- [ ] **EVIDENCE COLLECTION**: Code snippets, configurations, and technical proof for each determination
- [ ] Exploitability determination with detailed technical justification
- [ ] **UPDATE** `summary.md` with this CVE's exploitability summary and critical findings
- [ ] **UPDATE** `yyyy-mm-dd-report.md` with detailed analysis section for this CVE
- [ ] **Mark CVE task as completed** in todo list and move to next CVE

---
*Repeat above checklist for each CVE identified in Step 1*
---

### Final Documentation (after all CVEs analyzed):
- [ ] **COMPILE** final CVE exploitability summary table in `summary.md`
- [ ] **REVIEW** all CVE sections in `yyyy-mm-dd-report.md` for completeness
- [ ] **VERIFY** all CVEs have been thoroughly analyzed and documented


**Step 3 - VEX Creation**: 
- [ ] **CREATE** `vex.json` document with CVE exploitability determinations

**Step 4 - Final Documentation Review & Completion**: 
- [ ] **FINALIZE** `summary.md` with complete executive summary and recommendations
- [ ] **FINALIZE** `yyyy-mm-dd-report.md` with all technical details and remediation strategies
- [ ] **FINALIZE** `vex.json` with validated CVE statements and technical justifications
- [ ] All three documents stored in `docs/security/reports/[report-name]/` directory
- [ ] Quality assurance review of all deliverables for completeness and accuracy

**Final Verification**: 
- [ ] **CVE EXPLOITABILITY**: Every CVE determination backed by concrete technical evidence
- [ ] **PROGRESSIVE DOCUMENTATION**: All documents created and updated throughout analysis process
- [ ] **THREE DELIVERABLES**: Summary.md, detailed report, and VEX.json all completed and polished
- [ ] All VEX status justified with detailed technical reasoning
- [ ] Documentation demonstrates depth of analysis performed
- [ ] All files stored in correct directory structure: `docs/security/reports/[report-name]/`
- [ ] Deliverables ready for security team decision-making and include interim progress captured at each step
