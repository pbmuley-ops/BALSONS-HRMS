# BALSONS ERP & PAYROLL 2026 — Excel Bridge Design

| Field | Value |
|---|---|
| Document ID | BAL-XBR-001 |
| Version | 0.1.0-DRAFT |
| Status | PROPOSED — bridge source code not in workspace |
| Constraint | Zero-CSV; respect `ExportPortalDataDirectly` → `balsons_data.js` |

---

## 1. Purpose

Define the controlled synchronization path between the **Master Excel Workbook** (authoritative payroll data) and the **browser HTML application**.

---

## 2. Operating Requirement (mandated)

```text
Excel Workbook
    ↓
VBA: ExportPortalDataDirectly
    ↓
balsons_data.js
    ↓
HTML Application (validate → state → UI)
```

- **No CSV** intermediate format
- Direct Excel-to-HTML synchronization model
- Exact sheet names and column positions preserved via mapping objects

---

## 3. Bridge Pipeline

```text
Workbook Validation
        ↓
Employee Sync
        ↓
Month Sync
        ↓
Payroll Sync
        ↓
Write-back (authorized)
        ↓
Verification
        ↓
Audit
```

---

## 4. Components

| Component | Location | Responsibility |
|---|---|---|
| Master Workbook | `excel/` (placement decision pending) | SoR for employees, months, payroll formulas, payslip template |
| VBA Bridge | Inside workbook | Export/import routines; `ExportPortalDataDirectly` |
| `balsons_data.js` | Application root or generated path | Sync payload consumed by browser |
| Bridge module | `js/bridge/` | Load, parse, validate payload; invoke write services |
| Excel Data Service | `js/services/` | Domain-facing sync API |
| Validation Engine | `js/validation/` | Structural + domain validation |
| Audit Service | `js/services/` | Record sync/write/unlock events |

---

## 5. Read Path (detail)

1. Operator opens workbook and runs export (or approved automated trigger).
2. VBA writes/refreshes `balsons_data.js` with structured data (schema PENDING inspection).
3. HTML app loads `balsons_data.js` (script tag or dynamic import of local file — installation-defined).
4. Bridge validates:
   - payload presence/version
   - required sheets/entities
   - `EMPLOYEE DATABASE` mandated columns
   - month keys
   - type/range checks via validation engine
5. On success, Application State updated.
6. On failure, reject load; surface actionable errors; audit FAILURE.

---

## 6. Write Path (detail)

1. UI triggers domain service (never direct Excel from UI).
2. Validation Engine runs; invalid → abort.
3. Action Authorization checks permission (`excel:writeback`, `payroll:update`, etc.).
4. Excel Write Service / VBA write routine applies changes to workbook.
5. Re-export via `ExportPortalDataDirectly`.
6. Verification compares expected vs re-synced values for touched keys.
7. Audit SUCCESS/FAILED with before/after.

**Exact VBA write API is PENDING source inspection.** Design must adapt to existing modules rather than invent a parallel CSV path.

---

## 7. Sheet Sync Scopes

| Sync | Source | Target in app state | Notes |
|---|---|---|---|
| Employee Sync | `EMPLOYEE DATABASE` | `employees` | Columns via `EMPLOYEE_COLUMNS` |
| Month Sync | `MMM-YY` sheets | `months[monthKey]` | Naming PENDING confirm |
| Payroll Sync | Month payroll ranges / formulas | `payroll[monthKey]` | Consume workbook values/formulas |
| Payslip Template Sync | `PAYLIP TEMPLATE` | template map | Field map PENDING |
| Config Sync | Config sheet(s) if any | `config` | PENDING discovery |

---

## 8. `balsons_data.js` Contract (provisional)

Until the real export is inspected, the application must treat the payload as an **external contract** and validate defensively.

Recommended envelope (may differ from actual VBA — reconcile on inspection):

```javascript
// ILLUSTRATIVE ONLY — replace with actual ExportPortalDataDirectly schema
window.BALSONS_DATA = {
  meta: { exportedAt: '', workbookName: '', version: '' },
  employees: [ /* row objects keyed by mapping */ ],
  months: { /* monthKey: { attendance, payroll, ... } */ },
  payslipTemplate: { /* field map */ },
  config: { /* optional */ }
};
```

**Do not implement against this illustrative schema as if it were authoritative.**

---

## 9. SheetJS Role

SheetJS is on the approved technology list for client-side Excel assistance. Allowed uses (pending Architecture Review):

- Operator-selected workbook file parse for **verification / diagnostics**
- Generating offline copies for backup packages where VBA is unavailable

SheetJS must **not** silently become a second payroll SoR or introduce CSV export as the primary sync path.

---

## 10. Failure Modes

| Failure | Handling |
|---|---|
| Missing `balsons_data.js` | Block payroll modules; guide operator to export |
| Schema mismatch | Reject; show structural diff |
| Mandated column drift | Reject; critical alert |
| Partial month data | Reject or quarantine month (policy decision) |
| Write verification mismatch | Rollback policy PENDING; mark FAILED; audit |
| Unauthorized write | DENIED audit; no workbook change |

---

## 11. Security Controls

- Write-back requires role permission
- Payload validation before state hydration
- Audit every sync and write-back
- No execution of arbitrary code from workbook cells
- Macro trust documented in Admin Manual

---

## 12. Test Focus

- HTML ↔ bridge
- bridge ↔ Excel
- Employee/month/payroll sync round-trip
- Invalid workbook rejection
- Offline operation with local `balsons_data.js`
- Zero-CSV assurance (no CSV artifacts in sync path)

---

## 13. Open Items

1. Obtain VBA module source and document real procedure signatures.
2. Capture sample `balsons_data.js` from production-like workbook.
3. Decide write-back mechanism that preserves workbook formulas.
4. Decide file placement of generated `balsons_data.js` relative to `index.html`.
