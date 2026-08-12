# BALSONS ERP & PAYROLL 2026 — BEDS v3.0 Compliance Matrix

| Field | Value |
|---|---|
| Document ID | BAL-BEDS-001 |
| Version | 0.1.0-DRAFT |
| Status | MAPPING DRAFT — primary BEDS text NOT in workspace |
| Rule | Do **not** mark PASS without implementation evidence |

---

## 1. Scope and Caveat

BEDS v3.0 is mandatory. The primary BEDS document was **not found** in the workspace or accessible Drive. This matrix maps controls from the **initialization mandate** domains:

`BEDS-GOV`, `BEDS-ARC`, `BEDS-ENG`, `BEDS-UI`, `BEDS-SEC`, `BEDS-SDLC`, `BEDS-APP`, `BEDS-COMP`

When the official BEDS v3.0 text is supplied, this matrix must be reconciled to official control IDs.

### Allowed status values

`PASS` | `PARTIAL` | `FAIL` | `NOT APPLICABLE` | `PENDING`

---

## 2. Matrix

### BEDS-GOV — Governance

| CONTROL ID | REQUIREMENT | BALSONS IMPLEMENTATION | EXPECTED FILE | EXPECTED MODULE | TEST METHOD | STATUS | RISK |
|---|---|---|---|---|---|---|---|
| BEDS-GOV-01 | Documentation-first delivery | Docs package initiated | `docs/*` | N/A | Doc review | PARTIAL | Medium — primary BEDS text missing |
| BEDS-GOV-02 | Architecture-first before build | Architecture proposed; no app code | `docs/ARCHITECTURE.md` | N/A | Review gate | PARTIAL | Low |
| BEDS-GOV-03 | No production without testing | Test strategy drafted | `docs/TEST_PLAN.md` | `tests/` | Gate checklist | PENDING | High if skipped |
| BEDS-GOV-04 | Security verification before release | Security design proposed | `docs/SECURITY_DESIGN.md` | auth/rbac | Security suite | PENDING | High |
| BEDS-GOV-05 | Performance verification before release | Targets documented | `docs/NFR.md` | N/A | Perf suite | PENDING | Medium |
| BEDS-GOV-06 | UAT before release | UAT plan drafted | `docs/UAT_PLAN.md` | N/A | UAT sign-off | PENDING | High |
| BEDS-GOV-07 | Formal release approval | Release folder reserved | `release/` | Admin | Approval record | PENDING | High |
| BEDS-GOV-08 | Traceability to BEDS or workbook/spec | Initialization report | `docs/PROJECT_INITIALIZATION_REPORT.md` | N/A | Trace review | PARTIAL | High — sources missing |

### BEDS-ARC — Architecture

| CONTROL ID | REQUIREMENT | BALSONS IMPLEMENTATION | EXPECTED FILE | EXPECTED MODULE | TEST METHOD | STATUS | RISK |
|---|---|---|---|---|---|---|---|
| BEDS-ARC-01 | Layered separation UI→Excel | Documented layers | `docs/ARCHITECTURE.md` | `js/*` layers | Architecture review / code scan | PENDING | High |
| BEDS-ARC-02 | Excel authoritative payroll SoR | Declared; workbook missing | `excel/*`, bridge | `js/bridge`, `js/services` | Integration | FAIL | **Critical** — workbook absent |
| BEDS-ARC-03 | IndexedDB not payroll SoR | Boundary documented | `docs/ARCHITECTURE.md` | `js/state`, local services | Design + tests | PENDING | High |
| BEDS-ARC-04 | Modular module map | Module map approved in docs | `js/modules/*` | modules | Structure review | PENDING | Medium |
| BEDS-ARC-05 | No cross-module internals access | Rule documented | DEVELOPER_GUIDE | core | Lint/review | PENDING | Medium |
| BEDS-ARC-06 | No UI payroll business rules | Rule documented | modules vs services | services | Code review | PENDING | High |
| BEDS-ARC-07 | No business service DOM access | Rule documented | services | services | Code review | PENDING | Medium |
| BEDS-ARC-08 | No UI direct IndexedDB | Rule documented | state/local services | state | Code review | PENDING | Medium |
| BEDS-ARC-09 | Zero-CSV architecture | Mandated in bridge design | `docs/EXCEL_BRIDGE_DESIGN.md` | bridge | Integration | PENDING | High |
| BEDS-ARC-10 | Tech lock compliance | Lock documented | ARCHITECTURE / TECH | all | Dependency audit | PENDING | High |

### BEDS-ENG — Engineering

| CONTROL ID | REQUIREMENT | BALSONS IMPLEMENTATION | EXPECTED FILE | EXPECTED MODULE | TEST METHOD | STATUS | RISK |
|---|---|---|---|---|---|---|---|
| BEDS-ENG-01 | Offline-first core ops | Offline strategy documented | UI_UX / NFR / INSTALL | vendor assets | Offline suite | PENDING | High |
| BEDS-ENG-02 | Local-first / no runtime CDN | Vendor path reserved | `assets/vendor/` | assets | Offline + network block | PENDING | High |
| BEDS-ENG-03 | Excel-native exchange | Bridge design | EXCEL_BRIDGE_DESIGN | bridge | Integration | PENDING | High |
| BEDS-ENG-04 | Configurable rules | Config entity defined | DATA_DICTIONARY | config service | Functional | PENDING | Medium |
| BEDS-ENG-05 | Mapping objects for columns | Contract defined | EXCEL_MAPPING | mapping module | Unit | PARTIAL | High until frozen |
| BEDS-ENG-06 | Measurable performance targets | Targets listed | NFR | all | Perf tests | PENDING | Medium |
| BEDS-ENG-07 | Validation before commit | Validation engine designed | TEST_PLAN / validation | `js/validation` | Validation suite | PENDING | High |
| BEDS-ENG-08 | Maintainable structure | Folder scaffold created | repo tree | all | Structure review | PARTIAL | Low |

### BEDS-UI — User Interface

| CONTROL ID | REQUIREMENT | BALSONS IMPLEMENTATION | EXPECTED FILE | EXPECTED MODULE | TEST METHOD | STATUS | RISK |
|---|---|---|---|---|---|---|---|
| BEDS-UI-01 | Brand colors teal/red | Specced | `docs/UI_UX_SPEC.md`, `css/tokens.css` | css | Visual review | PENDING | Low |
| BEDS-UI-02 | Dark/light + persistent theme | Specced | tokens/base | core/theme | Functional | PENDING | Low |
| BEDS-UI-03 | Enterprise sidebar / breadcrumbs | Specced | layout.css | shell | UX review | PENDING | Low |
| BEDS-UI-04 | Accessible forms / focus / keyboard | Specced | UI_UX_SPEC | components | A11y checks | PENDING | Medium |
| BEDS-UI-05 | A4 print layouts | Specced | `css/print.css` | slips/reports | Print test | PENDING | Medium |
| BEDS-UI-06 | Native CSS Grid/Flexbox (no Bootstrap) | Mandated | css/* | css | Dependency audit | PENDING | Medium |
| BEDS-UI-07 | Minimal animation | Specced | UI_UX_SPEC | css | UX review | PENDING | Low |

### BEDS-SEC — Security

| CONTROL ID | REQUIREMENT | BALSONS IMPLEMENTATION | EXPECTED FILE | EXPECTED MODULE | TEST METHOD | STATUS | RISK |
|---|---|---|---|---|---|---|---|
| BEDS-SEC-01 | Authentication required | Design proposed | SECURITY_DESIGN | auth | Security tests | PENDING | High |
| BEDS-SEC-02 | Session management | Design proposed | SECURITY_DESIGN | session | Security tests | PENDING | High |
| BEDS-SEC-03 | RBAC with 8 required roles | Roles listed | SECURITY_DESIGN | rbac | Matrix tests | PENDING | High |
| BEDS-SEC-04 | Action authorization beyond UI | Design proposed | services | authz | Security tests | PENDING | High |
| BEDS-SEC-05 | Audit trail | Entity defined | DATA_DICTIONARY | audit | Security/functional | PENDING | High |
| BEDS-SEC-06 | Unlock reason + audit fields | Specified | SECURITY_DESIGN / payroll | payroll | Security tests | PENDING | High |
| BEDS-SEC-07 | No hardcoded production passwords | Policy stated | all source | auth | Secret scan | PENDING | Critical |
| BEDS-SEC-08 | Protect admin/config/write-back | Protected function list | SECURITY_DESIGN | admin | Security tests | PENDING | High |

### BEDS-SDLC — Lifecycle

| CONTROL ID | REQUIREMENT | BALSONS IMPLEMENTATION | EXPECTED FILE | EXPECTED MODULE | TEST METHOD | STATUS | RISK |
|---|---|---|---|---|---|---|---|
| BEDS-SDLC-01 | Functional test plan | Drafted | TEST_PLAN | tests/functional | Execute suite | PENDING | Medium |
| BEDS-SDLC-02 | Integration tests | Planned | TEST_PLAN | tests/integration | Execute | PENDING | High |
| BEDS-SDLC-03 | Validation tests | Planned | TEST_PLAN | tests/validation | Execute | PENDING | High |
| BEDS-SDLC-04 | Security tests | Planned | TEST_PLAN | tests/security | Execute | PENDING | High |
| BEDS-SDLC-05 | Performance tests | Planned | TEST_PLAN / NFR | tests/performance | Execute | PENDING | Medium |
| BEDS-SDLC-06 | Offline tests | Planned | TEST_PLAN | tests/offline | Execute | PENDING | High |
| BEDS-SDLC-07 | Regression each release | Folder reserved | tests/regression | tests | Gate | PENDING | Medium |
| BEDS-SDLC-08 | UAT plan | Drafted | UAT_PLAN | N/A | Sign-off | PENDING | High |
| BEDS-SDLC-09 | Change log / release notes | Draft stubs | CHANGE_LOG / RELEASE_NOTES | release | Doc review | PARTIAL | Low |

### BEDS-APP — Application Controls

| CONTROL ID | REQUIREMENT | BALSONS IMPLEMENTATION | EXPECTED FILE | EXPECTED MODULE | TEST METHOD | STATUS | RISK |
|---|---|---|---|---|---|---|---|
| BEDS-APP-01 | Payroll lifecycle states | Designed | ARCHITECTURE | payroll | Functional | PENDING | High |
| BEDS-APP-02 | Finalize lock + authorized unlock | Designed | SECURITY / ARCH | payroll | Security+functional | PENDING | High |
| BEDS-APP-03 | Employee sheet exact name/columns | Mapping partial | EXCEL_MAPPING | employee | Structure validation | PARTIAL | Critical until verified |
| BEDS-APP-04 | Direct Excel↔HTML sync via VBA/`balsons_data.js` | Bridge design | EXCEL_BRIDGE_DESIGN | bridge | Integration | FAIL | **Critical** — artifacts missing |
| BEDS-APP-05 | Salary slip / document generation | Spec only | UI_UX / DD | slips/hrdocs | Functional | PENDING | Medium |
| BEDS-APP-06 | Browser print/PDF | Specced | print.css | slips | Print test | PENDING | Medium |
| BEDS-APP-07 | Do not invent payroll formulas | Policy enforced in docs | EXCEL_MAPPING | payroll service | Review | PENDING | Critical |
| BEDS-APP-08 | Command Center / Workforce / Statutory / Reports / Admin / System | Module map | ARCHITECTURE | modules | Structure | PENDING | Medium |

### BEDS-COMP — Compliance / Statutory

| CONTROL ID | REQUIREMENT | BALSONS IMPLEMENTATION | EXPECTED FILE | EXPECTED MODULE | TEST METHOD | STATUS | RISK |
|---|---|---|---|---|---|---|---|
| BEDS-COMP-01 | PF module / reporting | Planned in module map | modules/statutory | pf | Functional | PENDING | High |
| BEDS-COMP-02 | ESIC module / reporting | Planned | modules/statutory | esic | Functional | PENDING | High |
| BEDS-COMP-03 | PT handling | Field in payroll catalogue | PAYROLL_FIELDS | payroll | Validation | PENDING | High |
| BEDS-COMP-04 | Configurable statutory rules | Config entity | DATA_DICTIONARY | config | Functional | PENDING | High |
| BEDS-COMP-05 | Auditable compliance actions | Audit design | SECURITY_DESIGN | audit | Security | PENDING | Medium |

---

## 3. Status Summary

| Status | Count | Notes |
|---|---|---|
| PASS | **0** | No implementation evidence |
| PARTIAL | 8 | Docs / mandated employee columns / scaffolds |
| FAIL | 2 | Workbook SoR absent; bridge artifacts absent |
| PENDING | Majority | Awaiting build + verification |
| NOT APPLICABLE | 0 | Pending official BEDS text reconciliation |

---

## 4. Blockers to Compliance Claims

1. Deliver BEDS v3.0 primary document and remap control IDs.
2. Deliver authoritative workbook + VBA + `balsons_data.js`.
3. Implement and test — only then may individual controls move to PASS.

---

## 5. Declaration

This matrix **does not claim BEDS compliance**. It is an initialization mapping for Architecture Review.
