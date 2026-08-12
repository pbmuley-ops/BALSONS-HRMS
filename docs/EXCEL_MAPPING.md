# BALSONS ERP & PAYROLL 2026 — Excel Mapping

| Field | Value |
|---|---|
| Document ID | BAL-XMAP-001 |
| Version | 0.2.0-DRAFT |
| Status | PARTIAL — enriched from SYSTEM SPECIFICATION; workbook binary still absent |
| Authority | Master workbook + `docs/SYSTEM_SPECIFICATION.md` |
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
| Workbook file name | `BALSONS ERP & PAYROLL 2026.xlsm` | Mandated by SYSTEM SPECIFICATION |
| Macro-enabled | YES (`.xlsm`) | Mandated |
| VBA module | `modBridgeEngine` | Mandated name |
| Export macro | `ExportPortalDataDirectly` (ALT+F8) | Mandated |
| Sync payload | `balsons_data.js` | Mandated |
| Authoritative for payroll | YES | Mandated |
| CSV exchange | FORBIDDEN | Mandated |
| Runtime co-location | Same folder as `portal.html`, logo, `balsons_data.js` | Mandated — see §11 |

**Action required:** Place authoritative workbook under approved path without structural modification. Binary inspection still pending.

---

## 3. Sheet Catalogue

| Sheet Name (exact) | Purpose | Status |
|---|---|---|
| `EMPLOYEE DATABASE` | Employee master | MANDATED |
| Month sheets with year id (e.g. `MAY-26`, `JUNE 26`) | Attendance + salary computation | MANDATED naming rule |
| Payslip / document templates | If present in workbook | PENDING binary |
| *Other sheets* | Config / hidden | PENDING binary |

### Month sheet naming

SYSTEM SPECIFICATION examples include both:

- `MAY-26` (hyphen)
- `JUNE 26` (space)

**Rule:** Month sheets **must include year identifiers** (`25` or `26`, etc.) so VBA can discover them dynamically. Exact separator/case rules must be confirmed from the live workbook discovery list — do not normalize names in code.

---

## 4. Employee Mapping — `EMPLOYEE_COLUMNS`

### Frozen (instruction-mandated — do not alter)

| Logical Key | Excel Column | Header (expected) | Notes |
|---|---|---|---|
| CODE | A | Emp Code / Employee Code | PK (e.g. `BAL-EMP001`) |
| NAME | B | Name / Full Name | |
| DESIGNATION | C | Designation | Values include `MECH`, `ELE`, `HELPER`, `ADMIN` |
| DOJ | D | DOJ | Date of Joining |
| MOBILE | E | Mobile | |
| STATUS | AZ (index 52) | Status | `Active` / `Inactive` |

### Columns F–Q — Personal & Statutory Demographics

SYSTEM SPECIFICATION states Columns **F to Q** hold:

> Gender, DOB, Marital Status, Father's Name, Physically Challenged, Address, City, State, Postal Code, PF Number, ESI Number, Aadhar Card No, Gross Salary

| Observation | Impact |
|---|---|
| Listed field count = **13** | |
| Column span F–Q = **12** columns | |
| Exact letter↔field assignment | **NOT FROZEN** — conflict until workbook headers are read |

**Provisional candidate order (NOT AUTHORITATIVE — workbook must confirm):**

| Candidate Order | Logical Key | Spec Label |
|---|---|---|
| 1 | gender | Gender |
| 2 | dob | DOB |
| 3 | maritalStatus | Marital Status |
| 4 | fatherName | Father's Name |
| 5 | physicallyChallenged | Physically Challenged |
| 6 | address | Address / Permanent Address |
| 7 | city | City |
| 8 | state | State |
| 9 | postalCode | Postal Code |
| 10 | pfNumber | PF Number |
| 11 | esiNumber | ESI Number |
| 12 | aadharNumber | Aadhar Card No |
| 13 | grossSalary | Gross Salary |

**Decision required:** Resolve 13-fields-vs-12-columns mismatch via workbook header row inspection. Until then, mapping objects must not hardcode F–Q letters for these fields beyond what A–E and AZ already freeze.

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
  // F–Q keys added only after workbook header audit resolves §4 conflict
});

export const SHEETS = Object.freeze({
  EMPLOYEE_DATABASE: 'EMPLOYEE DATABASE'
});

export const DESIGNATIONS = Object.freeze([
  'MECH',
  'ELE',
  'HELPER',
  'ADMIN'
]);

export const EMPLOYMENT_STATUS = Object.freeze({
  ACTIVE: 'Active',
  INACTIVE: 'Inactive'
});
```

---

## 5. Month Mapping — `MONTH_COLUMNS`

| Logical Key | UI Field (Attendance tab) | Excel Column / Range | Status |
|---|---|---|---|
| EMPLOYEE_CODE | Emp identity | PENDING | Must match master |
| PRESENT_DAYS | Present Days | PENDING | |
| WEEKLY_OFFS | Weekly Offs (WO) | PENDING | |
| PAID_LEAVES | Paid Leaves (PL) | PENDING | |
| OT_HOURS | Overtime (OT) Hours | PENDING | |
| ADVANCE | Advances (₹) | PENDING | |
| PAYABLE_DAYS | Payroll register | PENDING | |
| BASIC / HRA / DA / … | Payroll register | PENDING formulas | Do not invent |

```javascript
export const MONTH_COLUMNS = Object.freeze({
  // Populated after workbook inspection only
});
```

### Attendance grid persistence

- UI: Attendance Management → “Save to Excel”
- Binding: selected month sheet only
- Active employees only in interactive grid

### Inspection checklist (when workbook arrives)

- [ ] Sheet dimensions (used range)
- [ ] Header row(s) for month sheets
- [ ] Merged cells / named ranges / tables
- [ ] Data validations
- [ ] Formula cells for Basic, HRA, DA, Gross, PF, ESIC, Advances, Total Deductions, Net Payable
- [ ] Hidden rows/columns/sheets
- [ ] Protection / locked cells
- [ ] Exact month sheet name list (hyphen vs space)

---

## 6. Payroll Field Mapping — `PAYROLL_FIELDS`

Automation engine instructs Excel to evaluate underlying formulas. HTML must **display** workbook results, not invent replacements.

| Logical Key | Register Column (UI) | Excel Address / Formula | Status |
|---|---|---|---|
| employeeCode | Emp Code | PENDING | |
| name | Name | PENDING | |
| payableDays | Payable Days | PENDING | |
| basic | Basic | PENDING | |
| hra | HRA | PENDING | |
| da | DA | PENDING | |
| totalEarnings / gross | Total Earnings | PENDING | |
| pf | PF | PENDING | |
| esic | ESIC | PENDING | |
| advance | Advance | PENDING | |
| totalDeductions | Total Deductions | PENDING | |
| netPayable | NET PAYABLE | PENDING | |

```javascript
export const PAYROLL_FIELDS = Object.freeze({
  EMPLOYEE_CODE: 'employeeCode',
  NAME: 'name',
  PAYABLE_DAYS: 'payableDays',
  BASIC: 'basic',
  HRA: 'hra',
  DA: 'da',
  TOTAL_EARNINGS: 'totalEarnings',
  PF: 'pf',
  ESIC: 'esic',
  ADVANCE: 'advance',
  TOTAL_DEDUCTIONS: 'totalDeductions',
  NET: 'netPayable'
});
```

---

## 7. Payslip / Document Mapping — `PAYSLIP_FIELDS` / `HR_DOCUMENT_TYPES`

SYSTEM SPECIFICATION document types:

| Type Key | Label |
|---|---|
| appointment | Appointment Letters |
| joining | Joining Letters |
| ctcAnnexure | Annual CTC Annexure-I |
| salarySlip | Salary Spips / Salary Slips |
| experience | Experience Letters |
| relieving | Relieving Letters |
| noDue | No Due Certificates |
| idCard | Employee ID Cards |

Salary month selector appears only for salary slips. Template cell map: **PENDING workbook / template inspection**.

Print: `window.print()` / browser Print to PDF at 100% scale.

---

## 8. VBA Bridge Touchpoints

| Artifact | Role | Status |
|---|---|---|
| `modBridgeEngine` | VBA bridge module | Mandated name |
| `ExportPortalDataDirectly` | Export → `balsons_data.js` | Mandated; ALT+F8 |
| Employee scan | Row 2 → `LastRow` on `EMPLOYEE DATABASE` | Mandated |
| Dynamic month discovery | Sheets with year identifiers | Mandated |
| Write-back | Portal saves → Excel rows/sheets | Mandated (no CSV) |
| `balsons_data.js` | Browser payload | File PENDING |

See `docs/EXCEL_BRIDGE_DESIGN.md`.

---

## 9. Structural Validation Rules

On every sync, validate:

1. Required sheet `EMPLOYEE DATABASE` exists with exact name
2. Columns A–E and AZ still hold mandated fields (header check)
3. Discovered month sheets include year identifiers
4. Critical formula cells still contain formulas where integrity checks apply
5. Payload version / checksum (when available)

Failure → **reject sync**; do not load partial corrupt state into authoritative flows.

---

## 10. Change Control for Mapping

1. Inspect workbook change
2. Update this document
3. Update frozen mapping objects in `js/` (future)
4. Add validation + regression tests
5. Record in `CHANGE_LOG.md`
6. Obtain Architecture / Payroll Owner approval before release

**Forbidden:** silent column reorder, rename, or shift.

---

## 11. Runtime Co-location vs Source Tree

SYSTEM SPECIFICATION requires runtime co-location:

```text
portal.html
BALSONS LOGO MAIN NEW.png
balsons_data.js
BALSONS ERP & PAYROLL 2026.xlsm
```

Architecture source tree may remain modular (`css/`, `js/`, `docs/`, …) if a **release packaging** step produces the co-located operator folder. Decision: see Open Issues in PROJECT_INITIALIZATION_REPORT.

---

## 12. Mapping Completeness Score

| Area | Completeness |
|---|---|
| Employee A–E, AZ | Frozen by specification |
| Employee F–Q | Named fields listed; letter map unresolved (13 vs 12) |
| Month columns | UI fields known; Excel letters PENDING |
| Payroll formulas | Catalogue known; addresses PENDING |
| Document templates | Types known; cells PENDING |
| VBA export schema | Behaviour described; sample JS PENDING |

**Overall Excel Mapping status: PARTIAL (improved) — still blocked for formula freeze without workbook binary.**
