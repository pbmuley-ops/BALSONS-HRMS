# BALSONS ERP & PAYROLL 2026 — Developer Guide

| Field | Value |
|---|---|
| Document ID | BAL-DEV-001 |
| Version | 0.1.0-DRAFT |
| Status | GUIDANCE FOR PRE-IMPLEMENTATION |

---

## 1. Golden Rules

1. Trace every decision to **BEDS v3.0** or the **approved workbook/specification**.  
2. Do **not** invent payroll formulas.  
3. Do **not** shift Excel columns or rename mandated sheets.  
4. Do **not** introduce disallowed frameworks without formal BEDS exception.  
5. Do **not** put business rules in UI modules.  
6. Do **not** touch DOM from business services.  
7. Do **not** access IndexedDB from UI code.  
8. Do **not** use CSV in the sync path.  
9. Do **not** hardcode production passwords.  
10. Do **not** claim BEDS PASS without evidence.

---

## 2. Layer Rules

```text
UI → Presentation → Components → Business Logic → Validation → State
 → Data Services → Local/IDB → Excel Data Service → VBA Bridge → Workbook
```

---

## 3. Mapping Discipline

All column references via:

- `EMPLOYEE_COLUMNS`
- `MONTH_COLUMNS`
- `PAYROLL_FIELDS`
- `PAYSLIP_FIELDS`
- `SHEETS`

Update `docs/EXCEL_MAPPING.md` in the same change.

---

## 4. Tech Lock

Approved: HTML5, CSS3, Vanilla JS ES6+, SheetJS, IndexedDB, Chart.js, JSON, Print CSS, VBA, Excel.

Forbidden without exception: React/Angular/Vue/jQuery/Bootstrap/Node runtime/PHP/ASP.NET/Django/Laravel/SQL-NoSQL clouds/Electron.

---

## 5. Definition of Done (feature)

- Design docs updated  
- Validation rules added  
- AuthZ enforced  
- Audit events defined  
- Tests added under appropriate `tests/` folder  
- Offline-safe (no new CDN)  
- Changelog entry  

---

## 6. Current Repo State

Greenfield. Authoritative workbook/BEDS/spec files missing. Implementation not authorized until Architecture Review and source delivery.

---

## 7. Recommended First Implementation Slice (when authorized)

1. Vendor local libraries  
2. App shell + auth session stub  
3. Bridge loader + structural validation  
4. Employee read-only view from validated payload  
