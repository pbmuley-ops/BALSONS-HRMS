# BALSONS ERP & PAYROLL 2026 — Project Initialization Report

| Field | Value |
|---|---|
| Document ID | BAL-INIT-001 |
| Version | 0.2.0-DRAFT |
| Date | 2026-08-12 |
| Status | INITIALIZATION UPDATED — SYSTEM SPEC INGESTED; WORKBOOK / BEDS PRIMARY STILL BLOCKED |
| Classification | Internal — Architecture |
| Governance baseline | BEDS v3.0 (primary text not present; mapping from mandate + SYSTEM SPECIFICATION) |
| Application tech lock | HTML5, CSS3, Vanilla JS ES6+, SheetJS, IndexedDB, Chart.js, JSON, VBA, Microsoft Excel |
| Spec file | `docs/SYSTEM_SPECIFICATION.md` |

---

## 1. Executive Summary

The Cursor workspace for `BALSONS-HRMS` began as a **greenfield repository** (README only). Architecture documentation was produced without inventing payroll formulas.

**Update 2026-08-12:** The authoritative **INSTRUCTIONS / SYSTEM SPECIFICATION** was uploaded and ingested as `docs/SYSTEM_SPECIFICATION.md`. Excel mapping, data dictionary, UI/UX, bridge design, and architecture tab maps were updated from that text.

Still missing / blocked:

- BEDS v3.0 primary document
- Master workbook `BALSONS ERP & PAYROLL 2026.xlsm` (binary)
- VBA source / sample `balsons_data.js`
- Logo asset `BALSONS LOGO MAIN NEW.png`

**No application code, fake modules, placeholder UI, or invented payroll formulas were created.**

Cloud Agent environment setup (openpyxl install) was validated and proposed for Save separately.

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
| INSTRUCTIONS / SYSTEM SPECIFICATION | Markdown | Tab-by-tab + Excel binding + ops rules | BEDS + workbook | **INGESTED** as `docs/SYSTEM_SPECIFICATION.md` | **Authoritative** | Unblocks SRS detail | High |
| VBA (`modBridgeEngine`, `ExportPortalDataDirectly`) | Missing binary | Excel ↔ HTML bridge | Workbook | **MISSING** | Authoritative when supplied | ARC/ENG | **BLOCKED** |
| `balsons_data.js` | Missing | Sync payload for HTML | VBA export | **MISSING** | Authoritative when supplied | ARC/ENG | **BLOCKED** |
| `portal.html` / CSS / JS application | Missing | Frontend | Local vendors | **MISSING** | To be built under tech lock | UI/ENG | Pending |
| `BALSONS LOGO MAIN NEW.png` | Missing | Branding | — | **MISSING** | Non-authoritative asset | UI | Medium |

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
| OI-002 | Deliver `BALSONS ERP & PAYROLL 2026.xlsm` | Yes for formula/column freeze |
| OI-003 | SYSTEM SPECIFICATION | **Resolved** — ingested as `docs/SYSTEM_SPECIFICATION.md` |
| OI-004 | Authenticate Google Drive MCP if other files live in Drive | Conditional |
| OI-005 | Confirm month sheet naming (`MAY-26` vs `JUNE 26`) from live workbook | Yes for attendance |
| OI-006 | Extract VBA `modBridgeEngine` + sample `balsons_data.js` | Yes for bridge freeze |
| OI-007 | Resolve EMPLOYEE F–Q **13 fields vs 12 columns** | Yes before employee write-back |
| OI-008 | Bootstrap references in UI spec vs BEDS tech lock — prefer native CSS | Architecture decision |
| OI-009 | Runtime co-location vs modular source packaging | Architecture decision |
| OI-010 | Supply `BALSONS LOGO MAIN NEW.png` | UI package |

---

## 19. Required Decisions

1. **Workbook placement & packaging:** Co-located operator folder vs modular source + `release/` packager.
2. **Write-back mechanism:** Exact `modBridgeEngine` write APIs vs SheetJS-assisted paths — inspect VBA before coding.
3. **Auth store:** Local encrypted credential store vs OS-integrated auth (offline).
4. **Bootstrap exception?** Spec mentions Bootstrap; tech lock forbids it — recommend native CSS Grid/Flexbox unless exception approved.
5. **F–Q column map:** Resolve 13-vs-12 field mismatch from workbook headers.
6. **Release gate owners:** Named approvers under BEDS-GOV.

---

## 20. Recommended Development Sequence

```text
1. Supply workbook binary + BEDS primary + logo (spec now available)
2. Architecture Review (this package + SYSTEM SPECIFICATION)
3. Workbook deep inspection → freeze EXCEL_MAPPING + payroll formula catalogue
4. Technical Design (js contracts, IndexedDB schema, bridge API)
5. Vendor offline assets (SheetJS, Chart.js, fonts) under assets/vendor/
6. Core shell: tokens, layout, auth session, state bus (no fake payroll)
7. Excel bridge + validation + employee sync (read-only first)
8. Attendance → Payroll review (consume workbook formulas)
9. Documents / print / PDF
10. Reports + Settings
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
Workbook Audit:        BLOCKED (binary missing; name/bindings known from SYSTEM SPEC)
BEDS Mapping:          PARTIAL (mandate-based; primary text missing)
Architecture:          PROPOSED (updated from SYSTEM SPECIFICATION)
Security Design:       PROPOSED
Excel Mapping:         PARTIAL (A–E, AZ frozen; F–Q conflict; months/formulas pending)
Testing Strategy:      PROPOSED
System Specification:  INGESTED

Critical Risks:
1. Authoritative .xlsm still absent — formulas cannot be frozen.
2. BEDS v3.0 primary document still absent — official control IDs unverified.
3. EMPLOYEE F–Q lists 13 fields for 12 columns — mapping unsafe until workbook headers checked.
4. Bootstrap mentioned in UI spec conflicts with approved tech lock.

Critical Decisions Required:
1. Native CSS vs Bootstrap exception.
2. Release packaging for mandatory co-location of portal.html + xlsm + balsons_data.js + logo.
3. Exact write-back API surface inside modBridgeEngine.

NEXT APPROVED PHASE:
Architecture Review → Technical Design → Implementation
```