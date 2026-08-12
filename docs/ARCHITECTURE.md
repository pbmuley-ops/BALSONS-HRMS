# BALSONS ERP & PAYROLL 2026 — Architecture

| Field | Value |
|---|---|
| Document ID | BAL-ARC-001 |
| Version | 0.1.0-DRAFT |
| Status | PROPOSED — pending Architecture Review |
| Governance | BEDS v3.0 layered separation |
| Authority | Excel workbook = payroll source of truth |

---

## 1. Purpose

Define the enterprise architecture for **BALSONS ERP & PAYROLL 2026** as a BEDS v3.0-compliant, offline-first, Excel-native application. This document proposes structure and contracts only; it does not authorize implementation of fake modules or invented payroll formulas.

---

## 2. Architectural Principles

| ID | Principle | Implication |
|---|---|---|
| P-01 | Documentation-first | No feature without design evidence |
| P-02 | Architecture-first | Layer boundaries before UI coding |
| P-03 | Offline-first / local-first | Core ops without internet; local vendors |
| P-04 | Excel-native exchange | Zero-CSV; workbook authoritative |
| P-05 | Security-by-design | AuthZ on every protected action + audit |
| P-06 | Configurable rules | Statutory/payroll parameters not hardcoded |
| P-07 | Modular architecture | Module map isolation; no cross-internals |
| P-08 | Enterprise consistency | Shared tokens, components, patterns |
| P-09 | Measurable performance | Targets in NFR; verified by tests |
| P-10 | Formal releasability | No production without SDLC gates |

---

## 3. Layered Separation (BEDS)

```text
┌─────────────────────────────────────────────┐
│ UI (pages / views — no business rules)      │
├─────────────────────────────────────────────┤
│ Presentation (view models / binders)        │
├─────────────────────────────────────────────┤
│ Reusable Components (tables, forms, dialogs)│
├─────────────────────────────────────────────┤
│ Business Logic (payroll services consume    │
│ workbook-derived rules — do not invent)     │
├─────────────────────────────────────────────┤
│ Validation (reusable validation engine)     │
├─────────────────────────────────────────────┤
│ Application State (in-memory store)         │
├─────────────────────────────────────────────┤
│ Data Services (domain repositories)         │
├─────────────────────────────────────────────┤
│ Local Services / IndexedDB                  │
│ (cache, drafts, prefs, session — NOT payroll│
│  system of record)                          │
├─────────────────────────────────────────────┤
│ Excel Data Service (mapping + sync ops)     │
├─────────────────────────────────────────────┤
│ VBA Bridge (ExportPortalDataDirectly, etc.) │
├─────────────────────────────────────────────┤
│ Master Excel Workbook (authoritative)       │
└─────────────────────────────────────────────┘
```

### Hard rules

1. **No UI code contains payroll business rules.**
2. **No business service manipulates the DOM.**
3. **No UI code directly accesses IndexedDB.**
4. **No module directly manipulates another module’s internals.**
5. **IndexedDB is never a replacement payroll database.**

---

## 4. Technology Lock

### Approved

| Technology | Role |
|---|---|
| HTML5 | Application shell |
| CSS3 (Grid/Flexbox) | Layout / theme / print |
| Vanilla JavaScript ES6+ | Application logic |
| SheetJS | Client-side workbook parse/assist (as approved by bridge design) |
| IndexedDB | Local app state, cache, drafts, preferences, session |
| Chart.js | Dashboard / analytics charts |
| JSON | Config / sync payloads |
| HTML/CSS Print + Browser Print→PDF | Salary slips / documents |
| VBA | Controlled Excel bridge |
| Microsoft Excel | Authoritative workbook host |

### Forbidden (unless formal BEDS exception)

React, Angular, Vue, jQuery, Bootstrap, Node.js Runtime, PHP, ASP.NET, Django, Laravel, MySQL, PostgreSQL, MongoDB, Firebase, Supabase, Electron.

---

## 5. Proposed Project Structure

```text
BALSONS-ERP-PAYROLL-2026/
│
├── index.html
│
├── assets/
│   ├── logo/
│   └── vendor/          # SheetJS, Chart.js, fonts — offline
│
├── css/
│   ├── tokens.css       # Brand + theme tokens
│   ├── base.css
│   ├── layout.css
│   ├── components.css
│   ├── modules.css
│   └── print.css        # A4 salary slip / reports
│
├── js/
│   ├── core/            # bootstrap, events, errors, logger
│   ├── services/        # domain services (employee, payroll, …)
│   ├── validation/      # reusable validation engine
│   ├── state/           # application state store
│   ├── bridge/          # VBA / balsons_data.js integration
│   ├── modules/         # feature modules (UI orchestration only)
│   ├── reports/         # report generators
│   └── utilities/       # pure helpers (dates, money, format)
│
├── excel/               # Master workbook placement (decision pending)
│
├── docs/                # BEDS documentation package
│
├── backup/              # Backup packages / restore staging
│
├── reports/             # Generated report outputs (runtime)
│
├── release/             # Release manifests / approval artifacts
│
└── tests/
    ├── functional/
    ├── integration/
    ├── validation/
    ├── security/
    ├── performance/
    ├── offline/
    └── regression/
```

Structure may be adjusted only when justified by architecture review evidence.

---

## 6. Module Map

### COMMAND CENTER
- Dashboard — KPIs, period status, sync health
- Action Center — pending approvals / unlocks / reviews
- Notifications — system and workflow alerts

### WORKFORCE
- Employee Master — CRUD against Excel `EMPLOYEE DATABASE` via services
- Attendance — month sheet entry / review
- Payroll — calculation review driven by workbook logic
- Salary Slips — generation from `PAYLIP TEMPLATE` mappings
- HR Documents — templated employee documents

### STATUTORY
- PF, ESIC, Compliance — reports and rule configuration surfaces

### REPORTS
- Attendance, Payroll, Salary, OT, Advances, PF/ESIC, Management Analytics

### ADMINISTRATION
- Users, Roles, Configuration, Excel Sync, Audit, Backup / Restore

### SYSTEM
- Search, Help, About

---

## 7. Data Flow

### 7.1 Read / synchronization

```text
Master Excel Workbook
        ↓
VBA Bridge (ExportPortalDataDirectly)
        ↓
balsons_data.js  (zero-CSV)
        ↓
Workbook Structure Validation
        ↓
Domain Validation Engine
        ↓
Application State
        ↓
Presentation / UI
```

### 7.2 Write / write-back

```text
UI action
        ↓
Module orchestration (no business rules)
        ↓
Domain Service
        ↓
Validation Engine (reject invalid — never commit)
        ↓
Action Authorization (RBAC)
        ↓
Excel Write Service / VBA write path
        ↓
Master Workbook update
        ↓
Re-sync (ExportPortalDataDirectly → balsons_data.js)
        ↓
Audit record
```

### 7.3 IndexedDB usage (approved)

| Allowed | Forbidden |
|---|---|
| Session metadata | Authoritative employee master |
| UI preferences / theme | Authoritative monthly payroll totals |
| Draft forms before commit | Finalized payroll as SoR |
| Sync cache / last-good snapshot for offline UX | Replacing Excel formulas |
| Audit buffer pending flush | Bypassing validation |

---

## 8. Mapping Services (column isolation)

JavaScript must not hardcode scattered column letters. Dedicated mapping objects:

```javascript
// Conceptual contract — values frozen only after workbook audit
const EMPLOYEE_COLUMNS = {
  CODE: 'A',
  NAME: 'B',
  DESIGNATION: 'C',
  DOJ: 'D',
  MOBILE: 'E',
  STATUS: 'AZ'
  // … remaining columns PENDING workbook inspection
};

const MONTH_COLUMNS = { /* PENDING */ };
const PAYROLL_FIELDS = { /* PENDING — catalogue only until formulas extracted */ };
const PAYSLIP_FIELDS = { /* PENDING */ };
```

Sheet names are constants, never free-text in modules:

```javascript
const SHEETS = {
  EMPLOYEE_DATABASE: 'EMPLOYEE DATABASE',
  PAYSLIP_TEMPLATE: 'PAYLIP TEMPLATE' // exact workbook spelling
};
```

---

## 9. Payroll Control Model

```text
OPEN
 → ATTENDANCE ENTRY
 → ATTENDANCE REVIEW
 → PAYROLL CALCULATION
 → PAYROLL REVIEW
 → APPROVAL
 → FINALIZATION
 → SALARY SLIPS
 → MONTH CLOSED
```

- Finalized payroll requires authorization to unlock.
- Every unlock records: USER, ROLE, TIMESTAMP, MONTH, REASON, ACTION.

---

## 10. Validation Engine (design)

Reusable service validates:

- Required fields, data types, ranges, duplicates
- Cross-references (employee exists, month exists)
- Workbook structure & formula integrity checks (as detectable)
- Payroll rules & configuration rules

**Invalid data must never be committed.**

---

## 11. Excel Bridge (summary)

Full design: `docs/EXCEL_BRIDGE_DESIGN.md`.

Pipeline:

```text
Workbook Validation → Employee Sync → Month Sync → Payroll Sync
→ Write-back → Verification → Audit
```

Respect existing model: `ExportPortalDataDirectly` → `balsons_data.js`. No CSV intermediate.

---

## 12. Security Overlay

Full design: `docs/SECURITY_DESIGN.md`.

Cross-cutting: authentication, session, RBAC permissions, module access gates, action authorization, immutable audit trail.

---

## 13. Offline Strategy

1. Vendor all critical libraries under `assets/vendor/`.
2. No CDN for functional JS/CSS/fonts.
3. Application opens from local filesystem / local HTTP as approved by installation guide.
4. Excel remains local; bridge operates on local workbook.
5. Offline test matrix mandatory before release.

---

## 14. Performance Architecture Notes

- Lazy-load module scripts only if still offline-safe (local).
- Paginate large employee/month tables; virtualize if required to hit targets.
- Chart.js charts deferred until dashboard visible.
- Sync operations report progress; do not block UI thread without worker strategy (if used, still vanilla JS + approved stack only).

Targets: see `docs/NFR.md`.

---

## 15. Explicit Non-Goals (this phase)

- Building UI screens
- Implementing payroll calculators that invent formulas
- Introducing disallowed frameworks
- Claiming BEDS PASS
- Modifying workbook structure

---

## 16. Open Architecture Items

1. Freeze workbook formula catalogue after binary inspection.
2. Confirm SheetJS role vs pure VBA for write-back.
3. Confirm multi-user locking protocol.
4. Confirm auth storage mechanism for offline enterprise use.
5. Align BEDS control IDs with primary BEDS v3.0 text when supplied.

---

## 17. Approval

| Role | Name | Decision | Date |
|---|---|---|---|
| Lead Solution Architect | (agent draft) | PROPOSED | 2026-08-12 |
| Product Owner | | PENDING | |
| Security Engineer | | PENDING | |
| QA Architect | | PENDING | |
