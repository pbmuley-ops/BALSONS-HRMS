# BALSONS ERP & PAYROLL 2026 — Excel Mapping

| Field | Value |
|---|---|
| Document ID | BAL-XMAP-001 |
| Version | 0.1.0-DRAFT |
| Status | PARTIAL — workbook binary not available |
| Authority | Master Excel workbook (when supplied) |
| Constraint | Zero-CSV; exact sheet names; exact column positions |

---

## 1. Purpose

Freeze the contract between the HTML application and the master Excel workbook so that:

- Column indices are never scattered through JavaScript
- Sheet names are constants
- Payroll formulas remain workbook-owned
- Validation can detect structural drift

---

## 2. Workbook Identity

| Attribute | Value | Status |
|---|---|---|
| Workbook file name | *Unknown — not in workspace* | BLOCKED |
| Macro-enabled expected | Likely `.xlsm` (VBA bridge) | PENDING |
| Authoritative for payroll | YES | Mandated |
| CSV exchange | FORBIDDEN | Mandated |

**Action required:** Place authoritative workbook under `excel/` (or approved path) without structural modification.

---

## 3. Sheet Catalogue

| Sheet Name (exact) | Purpose | Status |
|---|---|---|
| `EMPLOYEE DATABASE` | Employee master | MANDATED — unverified |
| `MAY-26` | Example month sheet | Example from instructions |
| `JUNE-26` | Example month sheet | Example from instructions |
| `PAYLIP TEMPLATE` | Salary slip template | MANDATED name (spelling as given) |
| *Other sheets* | Config / statutory / hidden | PENDING full inventory |

### Month sheet naming

Pattern hypothesized from examples: `MMM-YY` (e.g., `MAY-26`).  
**Do not generate additional month sheets in docs as authoritative** until workbook confirms the convention (including separators, case, fiscal rules).

---

## 4. Employee Mapping — `EMPLOYEE_COLUMNS`

### Frozen (instruction-mandated — do not alter)

| Logical Key | Excel Column | Header (expected) | Notes |
|---|---|---|---|
| CODE | A | Employee Code | PK |
| NAME | B | Name | |
| DESIGNATION | C | Designation | |
| DOJ | D | DOJ | |
| MOBILE | E | Mobile | |
| STATUS | AZ | Status | |

### Pending (must be filled only from workbook)

| Excel Column | Observed Header | Logical Key | Type | Notes |
|---|---|---|---|---|
| F … AY | PENDING | PENDING | PENDING | Do not invent |
| BA … | PENDING | PENDING | PENDING | Do not invent |

### JavaScript mapping object (contract)

```javascript
/** @constant EMPLOYEE_COLUMNS — sole employee column registry */
export const EMPLOYEE_COLUMNS = Object.freeze({
  CODE: 'A',
  NAME: 'B',
  DESIGNATION: 'C',
  DOJ: 'D',
  MOBILE: 'E',
  STATUS: 'AZ'
  // Additional keys added only after workbook audit + change control
});

export const SHEETS = Object.freeze({
  EMPLOYEE_DATABASE: 'EMPLOYEE DATABASE',
  PAYSLIP_TEMPLATE: 'PAYLIP TEMPLATE'
});
```

---

## 5. Month Mapping — `MONTH_COLUMNS`

| Logical Key | Excel Column / Range | Purpose | Status |
|---|---|---|---|
| EMPLOYEE_CODE | PENDING | Row identity | PENDING |
| ATTENDANCE_* | PENDING | Daily / summary attendance | PENDING |
| OT_* | PENDING | Overtime inputs | PENDING |
| ADVANCE_* | PENDING | Advance inputs | PENDING |
| EARNINGS_* | PENDING | Earnings cells | PENDING |
| DEDUCTIONS_* | PENDING | Deduction cells | PENDING |
| NET_* | PENDING | Net payable | PENDING |

```javascript
export const MONTH_COLUMNS = Object.freeze({
  // Populated after workbook inspection only
});
```

### Inspection checklist (when workbook arrives)

- [ ] Sheet dimensions (used range)
- [ ] Header row(s)
- [ ] Merged cells
- [ ] Named ranges
- [ ] Tables / ListObjects
- [ ] Data validations
- [ ] Conditional formatting relevant to status
- [ ] Hidden rows/columns/sheets
- [ ] Protection / locked cells
- [ ] Every payroll formula and precedent/dependent tree

---

## 6. Payroll Field Mapping — `PAYROLL_FIELDS`

Catalogue of fields that **must** map to workbook cells/formulas:

| Logical Key | Category | Excel Address / Formula | Status |
|---|---|---|---|
| basic | Earnings | PENDING | Do not invent |
| hra | Earnings | PENDING | |
| da | Earnings | PENDING | |
| taCa | Earnings | PENDING | |
| oa | Earnings | PENDING | |
| lta | Earnings | PENDING | |
| overtimePay | Earnings | PENDING | |
| grossEarnings | Aggregate | PENDING | |
| pf | Deduction | PENDING | |
| esic | Deduction | PENDING | |
| advance | Deduction | PENDING | |
| pt | Deduction | PENDING | |
| totalDeductions | Aggregate | PENDING | |
| netPayable | Aggregate | PENDING | |

```javascript
export const PAYROLL_FIELDS = Object.freeze({
  // Keys only may be scaffolded; addresses after formula extraction
  BASIC: 'basic',
  HRA: 'hra',
  DA: 'da',
  TA_CA: 'taCa',
  OA: 'oa',
  LTA: 'lta',
  OVERTIME: 'overtimePay',
  GROSS: 'grossEarnings',
  PF: 'pf',
  ESIC: 'esic',
  ADVANCE: 'advance',
  PT: 'pt',
  TOTAL_DEDUCTIONS: 'totalDeductions',
  NET: 'netPayable'
});
```

---

## 7. Payslip Mapping — `PAYSLIP_FIELDS`

Source sheet: `PAYLIP TEMPLATE`

| Logical Key | Template Cell / Named Range | Data Source | Status |
|---|---|---|---|
| PENDING | PENDING | Employee / Payroll / Config | BLOCKED |

```javascript
export const PAYSLIP_FIELDS = Object.freeze({
  // Populated after template inspection
});
```

---

## 8. VBA Bridge Touchpoints

| Artifact | Role | Status |
|---|---|---|
| `ExportPortalDataDirectly` | Export workbook data to `balsons_data.js` | Mandated name — code PENDING |
| `balsons_data.js` | Browser-consumable sync payload | File PENDING |
| Write-back routines | UI → Excel | PENDING discovery |
| Verification routine | Post-write checks | PENDING |

See `docs/EXCEL_BRIDGE_DESIGN.md`.

---

## 9. Structural Validation Rules

On every sync, validate:

1. Required sheets exist with **exact** names
2. `EMPLOYEE DATABASE` columns A–E and AZ still hold mandated fields (header check)
3. Month sheet set matches expected open months
4. Critical formula cells still contain formulas (not accidentally overwritten with values) where integrity checks apply
5. Payload version / checksum (when available)

Failure → **reject sync**; do not load partial corrupt state into authoritative application flows.

---

## 10. Change Control for Mapping

1. Inspect workbook change
2. Update this document
3. Update frozen mapping objects in `js/` (future)
4. Add validation + regression tests
5. Record in `CHANGE_LOG.md`
6. Obtain Architecture / Payroll Owner approval before release

**Forbidden:** silent column reorder, rename, or shift to “make the UI easier.”

---

## 11. Mapping Completeness Score

| Area | Completeness |
|---|---|
| Employee mandated columns | Known (A–E, AZ) |
| Employee remaining columns | 0% observed |
| Month columns | 0% observed |
| Payroll formulas | 0% observed |
| Payslip fields | 0% observed |
| VBA export schema | 0% observed |

**Overall Excel Mapping status: PARTIAL / BLOCKED for implementation freeze.**
