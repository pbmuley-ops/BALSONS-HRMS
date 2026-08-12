# BALSONS ERP & PAYROLL 2026 — GitHub Copilot Engineering Instructions

## 1. Project Identity

Project: **BALSONS ERP & PAYROLL 2026**

This is an enterprise BALSONS workforce management and payroll application.

Primary capabilities:

* Employee Master
* Attendance
* Payroll
* Salary Slips
* HR Documents
* PF / ESIC
* Reports & Analytics
* Administration
* Excel Synchronization
* Audit
* Backup & Restore

---

# 2. GOVERNING STANDARD

**BEDS v3.0 — BALSONS ENTERPRISE DEVELOPMENT STANDARD** is the mandatory enterprise engineering baseline.

Every implementation must comply with the applicable BEDS controls:

* BEDS-GOV
* BEDS-ARC
* BEDS-ENG
* BEDS-UI
* BEDS-SEC
* BEDS-SDLC
* BEDS-APP
* BEDS-COMP

Do not weaken, bypass or silently ignore BEDS requirements.

Any deviation must be explicitly documented as an approved exception.

---

# 3. AUTHORITATIVE PROJECT SOURCES

Use these sources in this priority order:

1. Approved BEDS v3.0
2. Approved BALSONS ERP & PAYROLL 2026 SRS / instructions
3. Master BALSONS ERP & PAYROLL Excel workbook
4. Approved architecture and technical documentation
5. Existing implementation

Do not invent business rules when the workbook or specification already defines them.

Do not silently change workbook structure.

Do not silently change payroll formulas.

---

# 4. ARCHITECTURE PRINCIPLES

The application must use layered architecture:

```text
UI
↓
Presentation
↓
Reusable Components
↓
Business Logic
↓
Validation
↓
Application State
↓
Data Services
↓
Local Services
↓
Excel Data Service
↓
VBA Bridge
↓
Master Excel Workbook
```

Mandatory separation:

* UI contains presentation only.
* Business logic is independent from the DOM.
* Validation is independent from UI.
* Data access occurs through services.
* Modules communicate through defined interfaces.
* Configuration is separate from business logic.
* No duplicated business rules.

---

# 5. TECHNOLOGY STANDARD

Preferred technology:

* HTML5
* CSS3
* Vanilla JavaScript ES6+
* SheetJS
* IndexedDB
* Chart.js
* JSON
* HTML/CSS print
* Browser Print to PDF
* Microsoft Excel
* VBA bridge

Do NOT introduce the following without an approved BEDS exception:

* React
* Angular
* Vue
* jQuery
* Bootstrap
* Node.js runtime
* Firebase
* Supabase
* MySQL
* PostgreSQL
* MongoDB
* Electron

Use native CSS Grid/Flexbox instead of Bootstrap.

---

# 6. EXCEL IS THE PAYROLL SOURCE OF TRUTH

This project has a locked Zero-CSV / Direct Excel-to-HTML architecture.

The Excel workbook remains the authoritative payroll data source.

The application may use IndexedDB for:

* application state
* local preferences
* drafts
* cache
* synchronization metadata
* other approved local state

IndexedDB must NOT become an independent competing payroll database.

---

# 7. ZERO-CSV RULE

Never create, parse or depend on CSV files.

Do not introduce CSV as:

* temporary storage
* synchronization format
* import intermediary
* export intermediary
* backup intermediary

Use the approved Excel bridge.

---

# 8. EXCEL WORKBOOK INTEGRITY

The master workbook structure is locked.

Do not:

* rename required sheets
* delete required sheets
* reorder required columns
* shift required columns
* invent replacement sheets
* rewrite formulas without documented approval
* destroy formatting
* destroy workbook logic

Required master sheet:

`EMPLOYEE DATABASE`

Known mandatory mappings include:

```text
A  = Employee Code
B  = Name
C  = Designation
D  = DOJ
E  = Mobile
AZ = Employment Status
```

Monthly operating sheets use year-bearing names such as:

```text
MAY-26
JUNE-26
```

The application must discover these dynamically.

---

# 9. EXCEL MAPPING LAYER

Never scatter raw Excel column numbers throughout the code.

Create dedicated mapping modules.

Example:

```javascript
EMPLOYEE_COLUMNS
MONTH_COLUMNS
PAYROLL_FIELDS
PAYSLIP_FIELDS
```

All Excel read/write operations must pass through the mapping layer.

---

# 10. VBA BRIDGE

The Excel bridge must remain controlled.

Existing synchronization concepts include:

```text
ExportPortalDataDirectly
balsons_data.js
```

Do not replace the bridge with an unrelated data architecture.

All bridge operations must support:

* validation
* synchronization
* verification
* error handling
* audit
* version information

---

# 11. EMPLOYEE MASTER

Employee Master must support:

* Search
* Filter
* View
* Create
* Edit
* Activate
* Deactivate
* Validation
* Excel synchronization

Maintain the existing workbook field structure.

Never create a second employee database.

---

# 12. ATTENDANCE

Attendance must support:

* month discovery
* month selection
* month creation where approved
* employee filtering
* Present Days
* Weekly Off
* Paid Leave
* Overtime
* Advance
* validation
* save to Excel
* audit
* reload from Excel

Workflow:

```text
SELECT MONTH
↓
LOAD
↓
ENTER
↓
VALIDATE
↓
REVIEW
↓
SAVE
↓
AUDIT
```

---

# 13. PAYROLL

Payroll is a controlled transaction.

Workflow:

```text
OPEN
↓
ATTENDANCE
↓
VALIDATION
↓
CALCULATION
↓
REVIEW
↓
APPROVAL
↓
FINALIZATION
↓
SALARY SLIPS
↓
MONTH CLOSE
```

Do not invent payroll calculations if the workbook already defines them.

Respect workbook formulas and payroll dependencies.

Known payroll concepts include:

* Basic
* HRA
* DA
* TA/CA
* OA
* LTA
* Overtime
* Gross Earnings
* PF
* ESIC
* Advance
* PT
* Total Deductions
* Net Payable

---

# 14. PAYROLL FINALIZATION

Finalized payroll must be protected against accidental changes.

Unlocking finalized payroll requires:

* authorized role
* explicit confirmation
* reason
* audit record

---

# 15. SALARY SLIPS

Salary slips must support:

* individual generation
* bulk generation
* employee selection
* month selection
* live preview
* print
* browser PDF
* audit

Use the approved salary-slip template.

Do not invent statutory formatting when an approved template exists.

---

# 16. HR DOCUMENTS

Required document types include:

* Appointment Letter
* Joining Letter
* Annual CTC Annexure-I
* Salary Slip
* Experience Letter
* Relieving Letter
* No Due Certificate
* Employee ID Card

Documents must support controlled templates and versioning.

---

# 17. SECURITY

Implement security by design.

Required concepts:

* authentication
* session handling
* RBAC
* permission checks
* protected administration
* validation
* audit
* configuration protection
* backup controls

Roles may include:

* System Administrator
* HR Manager
* Payroll Manager
* Manager
* Supervisor
* Operator
* Viewer
* Auditor

Never hardcode production passwords.

Never expose secrets in source code.

---

# 18. AUDIT

Audit important events including:

* login
* logout
* employee create/update
* employee deactivate
* attendance save
* payroll calculation
* payroll approval
* payroll finalization
* payroll unlock
* salary slip generation
* HR document generation
* Excel synchronization
* settings changes
* backup
* restore

Audit records must not be editable through the normal application UI.

---

# 19. CONFIGURATION

Business rules must be configurable where practical.

Centralize:

* company information
* financial year
* payroll rules
* attendance rules
* OT rules
* statutory settings
* document configuration
* permissions
* approval rules
* numbering
* date formats
* currency

Do not hardcode business rules in multiple modules.

---

# 20. UI/UX

BALSONS identity:

```text
Primary: #0096A6
Secondary: #E03C42
```

Required:

* light mode
* dark mode
* responsive design
* enterprise sidebar
* breadcrumbs
* global search
* KPI cards
* filters
* tables
* sticky headers
* keyboard navigation
* focus indicators
* accessible controls
* print layouts
* A4 support

Avoid decorative UI that reduces usability.

---

# 21. OFFLINE-FIRST

Core business functionality must work without internet.

Critical libraries must be available locally.

Do not depend on external CDNs for core functionality.

Do not require online APIs for payroll processing.

Offline testing is mandatory.

---

# 22. PERFORMANCE TARGETS

Baseline targets:

```text
Startup              ≤ 3 seconds
Dashboard            ≤ 2 seconds
Navigation           ≤ 1 second
Record save          ≤ 2 seconds
Search               ≤ 2 seconds
Report generation    ≤ 10 seconds
Theme change         ≤ 0.5 seconds
Excel import         ≤ 15 seconds / 10,000 rows
Excel export         ≤ 15 seconds / 10,000 rows
```

Measure actual performance.

Do not claim compliance without evidence.

---

# 23. ERROR HANDLING

Errors must be:

* logged
* categorized
* visible to the user
* actionable
* safely recoverable where possible

Do not silently swallow exceptions.

Do not use empty catch blocks.

---

# 24. VALIDATION

Validation must cover:

* required fields
* types
* ranges
* duplicates
* employee references
* month references
* workbook structure
* business rules
* payroll rules
* configuration

Invalid data must not be committed.

---

# 25. TESTING

Every significant module requires tests.

Minimum categories:

* Unit
* Integration
* Functional
* UI
* Validation
* Performance
* Security
* Regression
* UAT

Do not mark features complete without testing.

---

# 26. DOCUMENTATION

Maintain:

```text
docs/
├── BRD.md
├── SRS.md
├── NFR.md
├── ARCHITECTURE.md
├── TECHNICAL_DESIGN.md
├── DATA_DICTIONARY.md
├── EXCEL_MAPPING.md
├── SECURITY_DESIGN.md
├── UI_UX_SPEC.md
├── TEST_PLAN.md
├── UAT_PLAN.md
├── BEDS_COMPLIANCE_MATRIX.md
├── BACKUP_RECOVERY.md
├── USER_MANUAL.md
├── ADMIN_MANUAL.md
├── DEVELOPER_GUIDE.md
├── RELEASE_NOTES.md
└── CHANGE_LOG.md
```

Keep documentation synchronized with the implementation.

---

# 27. FILE STRUCTURE

Preferred structure:

```text
BALSONS-ERP-PAYROLL-2026/
├── .github/
│   └── copilot-instructions.md
├── index.html
├── assets/
│   ├── logo/
│   └── vendor/
├── css/
├── js/
│   ├── core/
│   ├── services/
│   ├── validation/
│   ├── state/
│   ├── bridge/
│   ├── modules/
│   ├── reports/
│   └── utilities/
├── excel/
├── docs/
├── backup/
├── reports/
├── release/
└── tests/
```

---

# 28. DEVELOPMENT BEHAVIOR FOR COPILOT

When asked to implement a feature:

1. Inspect the relevant existing code.
2. Inspect the relevant documentation.
3. Inspect the Excel mapping if applicable.
4. Identify dependencies.
5. Check BEDS compliance.
6. Make the smallest clean architectural change.
7. Reuse existing services/components.
8. Add validation.
9. Add audit where required.
10. Add or update tests.
11. Update documentation.
12. Report exactly what changed.

Do not rewrite large portions of the application unnecessarily.

Do not create duplicate services.

Do not create duplicate business rules.

Do not implement functionality only in the UI.

---

# 29. NO FAKE IMPLEMENTATIONS

Never create:

```text
TODO
Coming Soon
Mock Data
Fake KPI
Fake payroll
Dummy calculation
Dead button
Placeholder workflow
Fake success message
```

unless the user explicitly asks for a prototype.

When required data is unavailable, show a proper empty state or validation message.

---

# 30. GIT DISCIPLINE

Make small, logical changes.

Use meaningful commit messages.

Do not mix unrelated changes in one commit.

Before suggesting a commit:

* inspect changed files
* inspect diff
* run relevant tests
* verify no accidental workbook changes
* verify documentation updates

Never commit secrets.

---

# 31. BEDS COMPLIANCE

Maintain:

```text
docs/BEDS_COMPLIANCE_MATRIX.md
```

Each control must map to:

```text
BEDS CONTROL
↓
IMPLEMENTATION
↓
FILE
↓
TEST
↓
EVIDENCE
↓
STATUS
```

Valid status:

```text
PASS
PARTIAL
FAIL
PENDING
N/A
```

Do not claim PASS without evidence.

---

# 32. RELEASE REQUIREMENT

No production release until:

* requirements approved
* architecture approved
* implementation complete
* security verified
* tests passed
* performance verified
* backup/restore verified
* UAT approved
* documentation complete
* BEDS compliance confirmed
* release approved

---

# 33. COPILOT RESPONSE STYLE

When explaining implementation:

1. State what you inspected.
2. State the recommended approach.
3. Implement only the requested scope.
4. Explain files changed.
5. Explain tests performed.
6. Identify remaining risks.

Never claim something was tested if it was not actually tested.

Never claim BEDS compliance without evidence.

---

# 34. FIRST TASK

For the initial repository setup, DO NOT build the ERP yet.

First:

1. Inspect all workspace files.
2. Inspect the Excel workbook and VBA.
3. Inspect BEDS documentation.
4. Create the architecture documents.
5. Create the Excel mapping document.
6. Create the BEDS compliance matrix.
7. Create the test plan.
8. Identify risks and conflicts.
9. Identify the exact first implementation milestone.

Then stop and report:

```text
BALSONS ERP & PAYROLL INITIALIZATION

Workspace Audit: COMPLETE
Workbook Audit: COMPLETE
BEDS Audit: COMPLETE
Architecture: READY
Excel Mapping: READY
Security Design: READY
Testing Strategy: READY

Critical Findings:
...

Critical Risks:
...

First Implementation Milestone:
...

Files Created:
...
```

Do not begin the next milestone until explicitly instructed.

## CORE PRINCIPLE

**BEDS v3.0 governs the engineering.**

**The approved ERP specification governs business requirements.**

**The Excel workbook governs existing payroll data structure and formulas.**

**Copilot assists implementation but does not replace architecture, QA, security, UAT or engineering ownership.**
