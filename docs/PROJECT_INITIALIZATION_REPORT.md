# BALSONS ERP & PAYROLL 2026 — Project Initialization Report

| Field | Value |
|---|---|
| Document ID | BAL-INIT-001 |
| Version | 0.1.0-DRAFT |
| Date | 2026-08-12 |
| Status | INITIALIZATION COMPLETE — WORKBOOK / BEDS SOURCE BLOCKED |
| Classification | Internal — Architecture |
| Governance baseline | BEDS v3.0 (text not present in workspace; mapping derived from task mandate) |
| Application tech lock | HTML5, CSS3, Vanilla JS ES6+, SheetJS, IndexedDB, Chart.js, JSON, VBA, Microsoft Excel |

---

## 1. Executive Summary

The Cursor workspace for `BALSONS-HRMS` is a **greenfield repository**. At inspection time it contained only `README.md` (`# BALSONS-HRMS`) and git metadata. No Excel workbook, VBA modules, HTML/CSS/JS application, BEDS v3.0 document, or system specification files were present in the workspace, GitHub `main`, or accessible MCP sources.

Google Drive MCP is connected to this environment but **requires authentication in Cursor Desktop** and could not be used to retrieve authoritative references from this cloud agent session.

This initialization phase therefore:

1. Completed a full **workspace audit** (empty application tree).
2. Recorded a **blocked workbook audit** pending delivery of the authoritative `.xlsx` / `.xlsm`.
3. Produced **architecture, security, data dictionary, Excel mapping, and BEDS compliance** documentation from the **task mandate** and known payroll specification constraints — **without inventing workbook formulas or altering any workbook structure**.
4. Established the approved modular folder scaffold and documentation package for Architecture Review → Technical Design → Implementation.

**No application code, fake modules, placeholder UI, or invented payroll formulas were created.**

---

## 2. Workspace Inventory

### 2.1 Inventory method

- Recursive filesystem listing of `/workspace`
- Git history / remote inspection (`origin` → `github.com/pbmuley-ops/BALSONS-HRMS`)
- GitHub Contents API (public repo confirms only `README.md` on `main`)
- Search for `*.xlsx`, `*.xlsm`, `*.bas`, `*.vba`, HTML/CSS/JS assets outside workspace
- Google Drive MCP status check (needsAuth)

### 2.2 File inventory (pre-documentation)

| FILE | TYPE | PURPOSE | DEPENDENCIES | STATUS | AUTHORITATIVE / NON-AUTHORITATIVE | BEDS IMPACT | PAYROLL IMPACT |
|---|---|---|---|---|---|---|---|
| `README.md` | Markdown | Repo title stub | None | Present | Non-authoritative | Documentation gap | None |
| `.git/*` | VCS | Version control | GitHub remote | Present | Non-authoritative | Traceability baseline | None |
| BEDS v3.0 document | Missing | Enterprise governance baseline | — | **MISSING** | **Authoritative (required)** | **BLOCKED** | Indirect |
| BALSONS ERP & PAYROLL 2026 workbook | Missing | Authoritative payroll data source | VBA bridge | **MISSING** | **Authoritative (required)** | ARC/APP | **BLOCKED** |
| INSTRUCTIONS / SYSTEM SPECIFICATION | Missing | System specification | BEDS + workbook | **MISSING** | **Authoritative (required)** | All domains | **BLOCKED** |
| VBA (`ExportPortalDataDirectly`, etc.) | Missing | Excel ↔ HTML bridge | Workbook | **MISSING** | Authoritative when supplied | ARC/ENG | **BLOCKED** |
| `balsons_data.js` | Missing | Sync payload for HTML | VBA export | **MISSING** | Authoritative when supplied | ARC/ENG | **BLOCKED** |
| HTML / CSS / JS application | Missing | Frontend | Local vendors | **MISSING** | To be built under tech lock | UI/ENG | Pending |
| Tests | Missing | Verification | Spec | **MISSING** | Non-authoritative | SDLC | Pending |
| Images / assets | Missing | Branding | — | **MISSING** | Non-authoritative | UI | Low |
| Duplicate / obsolete files | N/A | — | — | None found | — | — | — |

### 2.3 Inventory conclusion

| Area | Result |
|---|---|
| Application code | Not present |
| Excel workbook | Not present |
| VBA / bridge | Not present |
| Documentation package | Created in this phase (docs/) |
| Tests scaffold | Created empty category folders under `tests/` |
| Duplicates / obsolete | None |

---

## 3. Workbook Structure

### 3.1 Audit status: **BLOCKED**

The authoritative workbook was not available for binary inspection. The following is the **mandated structure from the project instructions**, to be verified 1:1 when the workbook is supplied.

### 3.2 Mandated sheets / naming (instruction-level)

| Sheet / artifact | Instruction constraint | Inspection status |
|---|---|---|
| `EMPLOYEE DATABASE` | Exact sheet name | PENDING verification |
| Month sheets (e.g. `MAY-26`, `JUNE-26`) | Exact month naming convention | PENDING verification |
| `PAYLIP TEMPLATE` | Spelling as supplied in instructions (note: “PAYLIP”) | PENDING verification |
| Other sheets (config, statutory, audit, etc.) | Unknown until workbook opens | PENDING |

### 3.3 Mandated `EMPLOYEE DATABASE` columns (must not be altered)

| Column | Field | Rule |
|---|---|---|
| A | Employee Code | Exact position — do not shift |
| B | Name | Exact position — do not shift |
| C | Designation | Exact position — do not shift |
| D | DOJ | Exact position — do not shift |
| E | Mobile | Exact position — do not shift |
| AZ | Status | Exact position — do not shift |

**Columns F–AY and beyond AZ are UNKNOWN until workbook inspection.** Mapping objects (`EMPLOYEE_COLUMNS`) must be completed only after workbook audit.

### 3.4 Monthly sheets

Expected to store attendance and payroll values for a calendar month. Exact headers, dimensions, formulas, merged cells, named ranges, tables, validations, and hidden sheets: **PENDING workbook audit**.

### 3.5 Payslip template

`PAYLIP TEMPLATE` field list, source cells, and formatting dependencies: **PENDING workbook audit**.

### 3.6 VBA / macros

Expected presence of sync routine(s) including `ExportPortalDataDirectly` producing `balsons_data.js`. Module inventory: **PENDING**.

---

## 4. Existing Payroll Logic

### 4.1 Status: **NOT OBSERVED IN WORKBOOK**

No formulas were extracted because the workbook file is absent. The following **component catalogue** is required by the specification and must be mapped to **actual workbook formulas** (not invented) during Technical Design:

| Component | Category | Source of truth | Status |
|---|---|---|---|
| Basic | Earnings | Workbook formula / cell | PENDING |
| HRA | Earnings | Workbook formula / cell | PENDING |
| DA | Earnings | Workbook formula / cell | PENDING |
| TA/CA | Earnings | Workbook formula / cell | PENDING |
| OA | Earnings | Workbook formula / cell | PENDING |
| LTA | Earnings | Workbook formula / cell | PENDING |
| Overtime | Earnings | Workbook formula / cell | PENDING |
| Gross earnings | Aggregate | Workbook formula | PENDING |
| PF | Deduction | Workbook formula / statutory rule | PENDING |
| ESIC | Deduction | Workbook formula / statutory rule | PENDING |
| Advance | Deduction | Workbook / entry | PENDING |
| PT | Deduction | Workbook formula / statutory rule | PENDING |
| Total deductions | Aggregate | Workbook formula | PENDING |
| Net payable | Aggregate | Workbook formula | PENDING |

**Rule:** Do not invent formulas where workbook formulas already define business logic.

---

## 5. Excel Mapping Summary

See `docs/EXCEL_MAPPING.md` for the mapping contract.

| Mapping object (planned) | Purpose | Status |
|---|---|---|
| `EMPLOYEE_COLUMNS` | Employee master column indices | PARTIAL (A–E, AZ known) |
| `MONTH_COLUMNS` | Monthly attendance/payroll columns | PENDING |
| `PAYROLL_FIELDS` | Calculated payroll field keys | PENDING (catalogue known) |
| `PAYSLIP_FIELDS` | Payslip template field map | PENDING |
| Sheet name constants | Exact workbook sheet names | PARTIAL |

**Principle:** Never scatter workbook column numbers throughout JavaScript; use dedicated mapping objects/services only.

---

## 6. BEDS Requirements Summary

BEDS v3.0 is the mandatory enterprise governance and engineering baseline. Primary PDF/DOCX was **not present**; the following domains are mandated by the initialization brief and mapped in `docs/BEDS_COMPLIANCE_MATRIX.md`:

| Domain | Focus |
|---|---|
| BEDS-GOV | Documentation-first, formal release approval, no production without UAT/security/performance |
| BEDS-ARC | Layered separation, modular architecture, Excel authoritative, IndexedDB non-authoritative for payroll |
| BEDS-ENG | Offline-first, local-first, Excel-native exchange, configurable rules, measurable performance |
| BEDS-UI | Enterprise consistency, accessibility, theming, native CSS Grid/Flexbox |
| BEDS-SEC | Security-by-design, RBAC, audit, no hardcoded production passwords |
| BEDS-SDLC | Testing, verification, UAT, documentation, release gates |
| BEDS-APP | Payroll lifecycle, module map, validation engine, bridge design |
| BEDS-COMP | Compliance/statutory (PF, ESIC, PT) and auditability |

**No control is marked PASS** — implementation evidence does not yet exist.

---

## 7. Architecture Proposal

See `docs/ARCHITECTURE.md`.

Approved layered stack:

```text
UI
↓ Presentation
↓ Reusable Components
↓ Business Logic
↓ Validation
↓ Application State
↓ Data Services
↓ Local Services / IndexedDB
↓ Excel Data Service
↓ VBA Bridge
↓ Master Excel Workbook
```

**Excel is the authoritative payroll data source. IndexedDB is not a replacement payroll database.**

Technology lock (approved):

- HTML5, CSS3, Vanilla JavaScript ES6+
- SheetJS, IndexedDB, Chart.js, JSON
- HTML/CSS Print + Browser Print to PDF
- VBA + Microsoft Excel

Technology lock (forbidden without formal BEDS exception):

- React, Angular, Vue, jQuery, Bootstrap
- Node.js Runtime, PHP, ASP.NET, Django, Laravel
- MySQL, PostgreSQL, MongoDB, Firebase, Supabase, Electron

---

## 8. Module Architecture

```text
COMMAND CENTER
├── Dashboard
├── Action Center
└── Notifications

WORKFORCE
├── Employee Master
├── Attendance
├── Payroll
├── Salary Slips
└── HR Documents

STATUTORY
├── PF
├── ESIC
└── Compliance

REPORTS
├── Attendance
├── Payroll
├── Salary
├── OT
├── Advances
├── PF / ESIC
└── Management Analytics

ADMINISTRATION
├── Users
├── Roles
├── Configuration
├── Excel Sync
├── Audit
└── Backup / Restore

SYSTEM
├── Search
├── Help
└── About
```

Proposed physical structure (docs-approved; code deferred):

```text
BALSONS-ERP-PAYROLL-2026/
├── index.html
├── assets/logo/  assets/vendor/
├── css/tokens.css base.css layout.css components.css modules.css print.css
├── js/core/ services/ validation/ state/ bridge/ modules/ reports/ utilities/
├── excel/
├── docs/
├── backup/
├── reports/
├── release/
└── tests/
```

---

## 9. Data Flow

### Read / sync

```text
EXCEL → VBA BRIDGE → balsons_data.js → VALIDATE → APPLICATION STATE → UI
```

### Write

```text
UI → SERVICE → VALIDATION → VBA / EXCEL WRITE SERVICE → WORKBOOK → SYNC → AUDIT
```

### Constraints

- No module may directly manipulate another module’s internals.
- No UI code may contain payroll business rules.
- No business service may directly manipulate the DOM.
- No UI code may directly access IndexedDB.
- Zero-CSV architecture; no CSV intermediate format.

---

## 10. Security Architecture

See `docs/SECURITY_DESIGN.md`.

```text
Authentication → Session → Role → Permission → Module Access → Action Authorization → Audit
```

Required roles: System Administrator, HR Manager, Payroll Manager, Manager, Supervisor, Operator, Viewer, Auditor.

Protected functions: user/role management, configuration, payroll finalization/unlock, Excel overwrite/write-back, backup/restore, import/synchronization, system maintenance.

---

## 11. Offline Architecture

- Core operations must not depend on internet connectivity.
- Critical libraries (SheetJS, Chart.js, fonts required for functionality) must be vendored under `assets/vendor/`.
- No runtime CDN dependency for JS/CSS/fonts required for application functionality.
- Test matrix: Internet ON / OFF, Wi-Fi OFF, external resources unavailable — core functions remain operational.

---

## 12. UI/UX Architecture

See `docs/UI_UX_SPEC.md`.

Brand:

- Primary Teal: `#0096A6`
- Secondary Red: `#E03C42`

Support: dark/light mode with persistent theme, enterprise sidebar, breadcrumbs, global search, quick actions, KPI cards, responsive tables, sticky headers, keyboard navigation, focus states, accessible forms, A4 print layouts. Native CSS Grid/Flexbox only. Minimal animation.

---

## 13. Performance Targets

| Metric | Target |
|---|---|
| Application startup | ≤ 3 sec |
| Dashboard load | ≤ 2 sec |
| Module navigation | ≤ 1 sec |
| Record save | ≤ 2 sec |
| Search | ≤ 2 sec |
| Report generation | ≤ 10 sec |
| Theme change | ≤ 0.5 sec |
| Excel import 10,000 rows | ≤ 15 sec |
| Excel export 10,000 rows | ≤ 15 sec |

These are **targets to be tested**, not assumptions.

---

## 14. Testing Strategy

See `docs/TEST_PLAN.md` and `docs/UAT_PLAN.md`. Categories:

- Functional, Integration, Validation, Security, Performance, Offline, Regression

`tests/` folder scaffold created with category subfolders. No fake test implementations in this phase.

---

## 15. Documentation Plan

| Document | Status this phase |
|---|---|
| `PROJECT_INITIALIZATION_REPORT.md` | Created |
| `ARCHITECTURE.md` | Created |
| `DATA_DICTIONARY.md` | Created (workbook fields PENDING) |
| `EXCEL_MAPPING.md` | Created (PARTIAL) |
| `SECURITY_DESIGN.md` | Created |
| `BEDS_COMPLIANCE_MATRIX.md` | Created (all PENDING/FAIL/PARTIAL) |
| `EXCEL_BRIDGE_DESIGN.md` | Created |
| `UI_UX_SPEC.md` | Created |
| `TEST_PLAN.md` / `UAT_PLAN.md` | Created |
| Remaining Phase 17 package | Created as controlled drafts |

---

## 16. BEDS Compliance Matrix

Full matrix: `docs/BEDS_COMPLIANCE_MATRIX.md`.

Summary counts (initialization):

| Status | Meaning | Count (approx.) |
|---|---|---|
| PENDING | Designed / documented, not implemented | Majority |
| PARTIAL | Spec known, evidence incomplete | Mapping / inventory |
| FAIL | Required artifact missing | Workbook, BEDS primary text, bridge |
| PASS | Implementation evidence exists | **0** |
| NOT APPLICABLE | Explicitly out of scope | TBD after BEDS primary text |

---

## 17. Known Risks

1. **Authoritative workbook absent** — cannot lock column maps, formulas, sheet inventory, or payslip layout.
2. **BEDS v3.0 primary document absent** — compliance matrix based on task-mandate domains; may miss numbered controls.
3. **VBA bridge / `balsons_data.js` absent** — sync contract unknown beyond `ExportPortalDataDirectly` name.
4. **Greenfield repo** — high risk of formula invention if implementation starts before workbook delivery.
5. **Google Drive MCP unauthenticated** — possible location of references inaccessible to this agent.
6. **Payslip sheet spelling (`PAYLIP TEMPLATE`)** — must preserve exact workbook name; risk of “correction” bugs.
7. **Offline vendor libraries not yet procured** — SheetJS/Chart.js/fonts must be licensed and vendored before coding.
8. **Statutory rule volatility (PF/ESIC/PT)** — must be configuration-driven, not hardcoded, after workbook review.

---

## 18. Open Issues

| ID | Issue | Blocking? |
|---|---|---|
| OI-001 | Deliver BEDS v3.0 document into workspace | Yes for final compliance PASS claims |
| OI-002 | Deliver BALSONS ERP & PAYROLL 2026 workbook | Yes for Excel mapping / payroll logic |
| OI-003 | Deliver SYSTEM SPECIFICATION / instructions file | Yes for SRS completeness |
| OI-004 | Authenticate Google Drive MCP if files live in Drive | Conditional |
| OI-005 | Confirm exact month sheet naming pattern and full column set | Yes for attendance module |
| OI-006 | Extract and freeze VBA bridge API surface | Yes for bridge design finalization |
| OI-007 | Confirm IndexedDB schema boundaries vs Excel authority | Architecture review |
| OI-008 | Confirm logo assets and print header requirements | UI package |

---

## 19. Required Decisions

1. **Workbook placement:** Commit macro-enabled workbook under `excel/` (with license/security review) vs keep outside repo and sync via controlled path?
2. **Write-back mechanism:** Pure VBA write service vs SheetJS write of a copy + operator-controlled merge — must align with existing `ExportPortalDataDirectly` model.
3. **Auth store:** Local encrypted credential store vs OS/Windows-integrated auth for offline enterprise use (no cloud IdP assumed).
4. **Multi-user concurrency:** Single-operator Excel file lock model vs explicit check-in/check-out protocol.
5. **Configuration ownership:** Which rules live in Excel sheets vs application configuration JSON (still Excel-synced)?
6. **Release gate owners:** Named approvers for security, performance, UAT, documentation under BEDS-GOV.

---

## 20. Recommended Development Sequence

```text
1. Supply authoritative references (BEDS, workbook, specification)
2. Architecture Review (this package)
3. Workbook deep inspection → freeze EXCEL_MAPPING + payroll formula catalogue
4. Technical Design (js module contracts, IndexedDB schema, bridge API)
5. Vendor offline assets (SheetJS, Chart.js, fonts) under assets/vendor/
6. Core shell: tokens, layout, auth session stub, state bus (no fake payroll)
7. Excel bridge + validation engine + employee sync (read-only first)
8. Attendance → Payroll review (consume workbook formulas; do not reimplement blindly)
9. Salary slips / print / PDF
10. Statutory + Reports
11. Administration (RBAC, audit, backup)
12. Security / performance / offline verification
13. UAT
14. Formal release approval (BEDS)
```

**STOP:** Do not proceed automatically into full implementation. Await next development instruction after Architecture Review.

---

## PROJECT INITIALIZATION STATUS

```text
PROJECT INITIALIZATION STATUS

Workspace Audit:       COMPLETE
Workbook Audit:        BLOCKED
BEDS Mapping:          PARTIAL (mandate-based; primary text missing)
Architecture:          PROPOSED
Security Design:       PROPOSED
Excel Mapping:         PARTIAL
Testing Strategy:      PROPOSED

Critical Risks:
1. Authoritative workbook not in workspace — formulas/columns cannot be frozen.
2. BEDS v3.0 primary document not in workspace — full control IDs unverified.
3. VBA bridge / balsons_data.js absent — sync contract incomplete.

Critical Decisions Required:
1. How/where to supply and version the master Excel workbook.
2. Exact write-back / sync model respecting ExportPortalDataDirectly.
3. Offline authentication and multi-user Excel concurrency model.

NEXT APPROVED PHASE:
Architecture Review → Technical Design → Implementation
```
