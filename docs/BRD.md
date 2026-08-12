# BALSONS ERP & PAYROLL 2026 — Business Requirements Document (BRD)

| Field | Value |
|---|---|
| Document ID | BAL-BRD-001 |
| Version | 0.1.0-DRAFT |
| Status | DRAFT — pending SYSTEM SPECIFICATION file |

---

## 1. Business Goals

1. Digitize payroll operations with an enterprise HTML UI.
2. Keep Excel workbook as the single authoritative payroll data source.
3. Enforce controlled monthly payroll lifecycle with auditability.
4. Support statutory reporting (PF, ESIC, PT-related outputs).
5. Operate reliably offline on office workstations.

---

## 2. Business Actors

System Administrator, HR Manager, Payroll Manager, Manager, Supervisor, Operator, Viewer, Auditor.

---

## 3. Business Requirements

| ID | Requirement | Priority | Source |
|---|---|---|---|
| BR-01 | Maintain employee master aligned to `EMPLOYEE DATABASE` | Must | Spec |
| BR-02 | Capture monthly attendance in month sheets | Must | Spec |
| BR-03 | Calculate/review payroll using workbook logic | Must | Spec / Workbook |
| BR-04 | Generate salary slips and print/PDF | Must | Spec |
| BR-05 | Generate HR documents with substitutions | Should | Spec |
| BR-06 | Produce statutory and management reports | Must | Spec |
| BR-07 | Synchronize Excel↔HTML without CSV | Must | Spec |
| BR-08 | Role-based access and audit | Must | BEDS-SEC |
| BR-09 | Finalize/lock months; authorized unlock with reason | Must | Spec |
| BR-10 | Backup and restore | Must | BEDS |
| BR-11 | Configurable business/statutory rules | Must | BEDS-ENG |
| BR-12 | Offline core operations | Must | BEDS-ENG |

---

## 4. Business Rules (high level)

- Excel remains SoR for payroll figures.
- Invalid data never committed.
- Finalized payroll cannot be silently changed.
- Column positions A–E and AZ on employee sheet are immutable.

---

## 5. Assumptions & Dependencies

- Authoritative workbook and BEDS v3.0 document will be supplied.
- VBA export routine `ExportPortalDataDirectly` exists or will be provided with workbook.
- Operators have Microsoft Excel suitable for macro-enabled workbook policy.

## 6. Risks

See `PROJECT_INITIALIZATION_REPORT.md` §17.
