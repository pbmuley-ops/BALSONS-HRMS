# BALSONS ERP & PAYROLL 2026 — Architecture

| Field | Value |
|---|---|
| Document ID | BAL-ARC-001 |
| Version | 0.2.0-DRAFT |
| Status | PROPOSED — pending Architecture Review |
| Governance | BEDS v3.0 layered separation |
| Authority | Excel workbook = payroll source of truth |
| Spec ingested | `docs/SYSTEM_SPECIFICATION.md` (2026-08-12) |

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
BALSONS-ERP-PAYROLL-2026/          # source / engineering tree
│
├── portal.html                    # SYSTEM SPEC entry (or index.html alias)
│
├── assets/
│   ├── logo/                      # BALSONS LOGO MAIN NEW.png
│   └── vendor/                    # SheetJS, Chart.js, fonts — offline
│
├── css/
│   ├── tokens.css
│   ├── base.css
│   ├── layout.css
│   ├── components.css
│   ├── modules.css
│   └── print.css
│
├── js/
│   ├── core/
│   ├── services/
│   ├── validation/
│   ├── state/
│   ├── bridge/                    # balsons_data.js loader + sync
│   ├── modules/
│   ├── reports/
│   └── utilities/
│
├── excel/                         # Master .xlsm in source control policy TBD
├── docs/
├── backup/
├── reports/
├── release/                       # co-located operator package output
├── scripts/
└── tests/
```

### Runtime operator package (SYSTEM SPECIFICATION mandatory)

When deployed for operators, these files **must share one folder**:

```text
portal.html
BALSONS LOGO MAIN NEW.png
balsons_data.js
BALSONS ERP & PAYROLL 2026.xlsm
```

Engineering tree may stay modular if `release/` packaging produces that co-located folder.

Structure may be adjusted only when justified by architecture review evidence.

---

## 6. Module Map

### 6.1 Spec tabs (`portal.html` hashes)

| Hash | Capability |
|---|---|
| `#dashboard` | KPI cards + Chart.js analytics |
| `#employee-master` | Employee table + `#employeeModal` |
| `#attendance` | Month selector, grid, Save to Excel, New Month Sheet |
| `#payroll` | Compute Payroll + register preview |
| `#documents` | HR docs / slips generator + `#documentPrintArea` |
| `#reports` | Registers & analytics print views |
| `#settings` | Company profile + statutory codes |

### 6.2 Enterprise groups (BEDS — remain mandatory)

### COMMAND CENTER
- Dashboard — KPIs, period status, sync health (`#dashboard`)
- Action Center — pending approvals / unlocks / reviews
- Notifications — system and workflow alerts

### WORKFORCE
- Employee Master — CRUD against Excel `EMPLOYEE DATABASE` (`#employee-master`)
- Attendance — month sheet entry / review (`#attendance`)
- Payroll — workbook-driven calculation review (`#payroll`)
- Salary Slips — via Documents tab salary-slip mode (`#documents`)
- HR Documents — templated certificates (`#documents`)

### STATUTORY
- PF, ESIC, Compliance — reports + settings statutory fields

### REPORTS
- Attendance, Wage, Salary, Employee List, OT, Advances, PF/ESIC (`#reports`)
- Management Analytics — dashboard charts

### ADMINISTRATION
- Users, Roles, Configuration (`#settings` + extended admin screens)
- Excel Sync, Audit, Backup / Restore

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

1. Freeze workbook formula catalogue after binary inspection (`BALSONS ERP & PAYROLL 2026.xlsm`).
2. Resolve EMPLOYEE F–Q **13 fields vs 12 columns** mismatch (see EXCEL_MAPPING).
3. Confirm month sheet naming variants (`MAY-26` vs `JUNE 26`) from live discovery.
4. Confirm SheetJS role vs pure VBA for write-back (`modBridgeEngine`).
5. Bootstrap vs native CSS — prefer native per tech lock; exception only if approved.
6. Confirm multi-user locking protocol.
7. Confirm auth storage mechanism for offline enterprise use.
8. Align BEDS control IDs with primary BEDS v3.0 text when supplied.
9. Release packaging to satisfy co-location rule without abandoning modular source.

---

## 17. Approval

| Role | Name | Decision | Date |
|---|---|---|---|
| Lead Solution Architect | (agent draft) | PROPOSED | 2026-08-12 |
| Product Owner | | PENDING | |
| Security Engineer | | PENDING | |
| QA Architect | | PENDING | |
